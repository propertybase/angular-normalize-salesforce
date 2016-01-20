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
      string.toLowerCase().replace(/__c$/, '')

    _normalizeArray: (array) =>
      _.map array, (element) =>
        @normalize(element)

    _normalizeObject: (object) =>
      normalized = {}

      _.each object, (value, key) =>
        if _(value).isObject() && !_(value).isFunction() && !_.isDate(value)
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
        if _(value).isObject() && !_(value).isFunction()
          denormalized[@denormalize(key, sObject)] = @denormalize(
            value, sObject
          )
        else
          denormalized[@denormalize(key, sObject)] = value
        true

      denormalized
