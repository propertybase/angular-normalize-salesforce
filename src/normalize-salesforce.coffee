'use strict'

angular.module('angular-normalize-salesforce')
.factory 'normalizeSalesforce', (
  ansSalesforceSObjects,
  ansSalesforceStandardObjects,
  ansSalesforceStandardFields
) ->
  new class NormalizeSalesforce
    constructor: ->
      @standardFields = ansSalesforceStandardFields
      @standardObjects = ansSalesforceStandardObjects
      @sObjectFields = ansSalesforceSObjects

    normalize: (part) =>
      if _.isNull(part) || _.isUndefined(part)
        return if _.isNull(part) then null else undefined

      type_name = Object.prototype.toString.call(part)

      switch
        when _(part).isString() then @_normalizeString(part)
        when _(part).isArray()  then @_normalizeArray(part)
        when _(part).isObject() then @_normalizeObject(part)
        else
          throw new Error(
            "Type #{type_name} not supported.
            Only String, Array and Object are supported."
          )

    denormalize: (part, sObject, map={}) =>
      type_name = Object.prototype.toString.call(part)

      switch
        when _(part).isString() then @_denormalizeString(part, sObject, map)
        when _(part).isArray()  then @_denormalizeArray(part, sObject)
        when _(part).isObject() then @_denormalizeObject(part, sObject)
        else
          throw new Error(
            "Type #{type_name} not supported.
            Only String, Array and Object are supported."
          )

    denormalizeObjectName: (name) =>
      @_denormalize name, @standardObjects

    # PRIVATE ----------

    _normalizeString: (string) ->
      if @_isSalesforceId string
        string
      else
        string.toLowerCase().replace(/__c$/, '')

    _normalizeArray: (array) =>
      _.map array, (element) =>
        @normalize(element)

    _normalizeObject: (object) =>
      normalized = {}

      _.each object, (value, key) =>
        if _(value).isObject() && !_(value).isFunction() && !_(value).isDate()
          normalized[@normalize(key)] = @normalize(value)
        else
          normalized[@normalize(key)] = value
        true

      normalized

    _denormalize: (part, avoidList, prefix=undefined) ->
      unless _(avoidList).contains(part) || _.endsWith(part, '__s')
        if prefix then "#{prefix}.#{part}__c" else "#{part}__c"
      else
        if prefix then "#{prefix}.#{part}" else part

    _denormalizeString: (string, sObject, map) =>
      stringParts = string.split('.')
      if stringParts.length > 1 && _.has(map,stringParts[0])
        parentRef = stringParts[0]
        string = stringParts[1]
        sObject = @normalize(map[parentRef])
      else
        string = stringParts[0]
        sObject = @normalize(sObject)

      standardFields = @standardFields
      if _(@sObjectFields).has(sObject)
        standardFields = _.uniq(standardFields.concat(@sObjectFields[sObject]))

      @_denormalize string, standardFields, parentRef

    _denormalizeArray: (array, sObject) =>
      _.map array, (element) =>
        @denormalize(element, sObject)

    _denormalizeObject: (object, sObject) =>
      denormalized = {}

      _.each object, (value, key) =>
        if _(value).isObject() && !_(value).isFunction() && !_(value).isDate()
          denormalized[@denormalize(key, sObject)] = @denormalize(
            value, sObject
          )
        else
          denormalized[@denormalize(key, sObject)] = value
        true

      denormalized

    # Returns whether the given string is a salesforce id
    _isSalesforceId: (value) ->
      return false if typeof value != 'string'
      return false if value.length != 18
      return false unless /^[A-Za-z0-9]+$/.test value

      shortId = value.substr(0, 15)
      compareId = @_get18DigitSalesforceId(shortId)

      # We check whether the computed 18 digit number
      # euqals the stripped 15 digit number
      # to make sure this is a SF id
      value == compareId


    _get18DigitSalesforceId: (id) ->
      _isUppercase = (c) -> new RegExp(c).test uppercaseAlphabet

      if id and id.length == 18
        return id
      if !(id and id.length == 15)
        throw new Error('Salesforce Id was neither 18 nor 15 chars')
      uppercaseAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      i = undefined
      j = undefined
      flags = undefined
      alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ012345'
      i = 0
      while i < 3
        flags = 0
        j = 0
        while j < 5
          if _isUppercase(id.charAt(i * 5 + j))
            flags += 1 << j
          j++
        id += alphabet.charAt(flags)
        i++
      id
