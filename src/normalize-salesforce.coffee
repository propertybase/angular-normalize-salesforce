'use strict'

angular.module('angular-normalize-salesforce')
.service 'normalizeSalesforce',
  class NormalizeSalesforce
    constructor: (
      ansSalesforceSObjects,
      ansSalesforceStandardObjects,
      ansSalesforceStandardFields
    ) ->
      @standardFields = ansSalesforceStandardFields
      @standardObjects = ansSalesforceStandardObjects
      @sObjectFields = ansSalesforceSObjects

    normalize: (part) =>
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

    _normalizeString: (string) ->
      string.toLowerCase().replace('__c', '')

    _normalizeArray: (array) =>
      _.map array, (element) =>
        @normalize(element)

    _normalizeObject: (object) =>
      normalized = {}

      _(object).forEach (value, key) =>
        if _(value).isObject() && !_(value).isFunction()
          normalized[@normalize(key)] = @normalize(value)
        else
          normalized[@normalize(key)] = value

      normalized

    denormalize: (part, sObject) =>
      type_name = Object.prototype.toString.call(part)

      switch
        when _(part).isString() then @_denormalizeString(part, sObject)
        when _(part).isArray()  then @_denormalizeArray(part, sObject)
        when _(part).isObject() then @_denormalizeObject(part, sObject)
        else
          throw new Error(
            "Type #{type_name} not supported.
            Only String, Array and Object are supported."
          )

    denormalizeObjectName: (name) =>
      @_denormalize name, @standardObjects

    _denormalize: (part, avoidList) ->
      unless _(avoidList).contains(part)
        "#{part}__c"
      else
        part

    _denormalizeString: (string, sObject) =>
      sObject = @normalize(sObject)

      standardFields = @standardFields
      if _(@sObjectFields).has(sObject)
        standardFields = _.uniq(standardFields.concat(@sObjectFields[sObject]))

      @_denormalize string, standardFields

    _denormalizeArray: (array, sObject) =>
      _.map array, (element) =>
        @denormalize(element, sObject)

    _denormalizeObject: (object, sObject) =>
      denormalized = {}

      _(object).forEach (value, key) =>
        if _(value).isObject() && !_(value).isFunction()
          denormalized[@denormalize(key, sObject)] = @denormalize(
            value, sObject
          )
        else
          denormalized[@denormalize(key, sObject)] = value

      denormalized
