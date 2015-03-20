'use strict'

describe 'Service: normalizeSalesforce', ->
  normalizeSalesforce = null

  beforeEach ->
    angular.mock.module 'angular-normalize-salesforce'
    angular.mock.inject (_normalizeSalesforce_) ->
      normalizeSalesforce = _normalizeSalesforce_

  describe '#normalize', ->

    # ------------------
    # Field Operations

    it 'lowercases a standard salesforce field', ->
      expect normalizeSalesforce.normalize('Name')
        .to.equal 'name'

    it 'removes __c from the field name and lowercases it', ->
      expect normalizeSalesforce.normalize('Field__c')
        .to.equal 'field'
      expect normalizeSalesforce.normalize('field__c')
        .to.equal 'field'

    it 'preserves namespace to avoid field conflicts', ->
      expect normalizeSalesforce.normalize('ns__Field__c')
        .to.equal 'ns__field'
      expect normalizeSalesforce.normalize('ns__cField__c')
        .to.equal 'ns__cfield'

    # ------------------
    # Object Operations

    it 'iterates over an object and normalizes every key', ->
      object =
        'Field1__c': 'value1'
        'field2__c': 'value2'
        'ns__Field1__c': 'value3'
        'Name': 'value4'

      expect normalizeSalesforce.normalize(object)
        .to.deep.equal
          'field1': 'value1'
          'field2': 'value2'
          'ns__field1': 'value3'
          'name': 'value4'

    it 'normalizes falsy values', ->
      object =
        'field1': 'value1'
        'field2': false
        'field3': 'value3'
      expect(normalizeSalesforce.normalize object).to.deep.equal(object)

    it 'supports nested objects', ->
      object =
        'Field1__c': 'value1'
        'Field2':
          'ns__Field1__c': 'value2'
          'Id': 1

      expect normalizeSalesforce.normalize(object)
        .to.deep.equal
          'field1': 'value1'
          'field2':
            'ns__field1': 'value2'
            'id': 1

    it 'normalizes every value in an array', ->
      expect(normalizeSalesforce.normalize(
        ['Field1__c', 'Name', 'NS__Field1__c']
      )).to.deep.equal(
        ['field1', 'name', 'ns__field1']
      )

    # ------------------

    it 'throws an error if unsupported type is used', ->
      expect -> normalizeSalesforce.normalize(2)
        .to.throw Error

    it 'ignores null and undefined', ->
      expect normalizeSalesforce.normalize(null)
        .to.be.null
      expect normalizeSalesforce.normalize(undefined)
        .to.be.undefined

  describe '#denormalize', ->
    context 'of custom object', ->
      object = 'customobject'

      it 'adds __c to custom fields', ->
        expect normalizeSalesforce.denormalize('customfield', object)
          .to.equal 'customfield__c'

      it 'also adds __c to custom fields that sound like a standard object', ->
        expect normalizeSalesforce.denormalize('account', object)
          .to.equal 'account__c'

      it 'keeps standard fields clean', ->
        expect normalizeSalesforce.denormalize('id', object)
          .to.equal 'id'

      it 'supports also denormalized custom object names', ->
        expect normalizeSalesforce.denormalize('field', 'CustomObject__c')
          .to.equal 'field__c'

    context 'of standard object', ->
      object = 'account'

      it 'adds __c to custom fields', ->
        expect normalizeSalesforce.denormalize('customfield', object)
          .to.equal 'customfield__c'

      it 'keeps standard fields clean', ->
        expect normalizeSalesforce.denormalize('shippingcity', object)
          .to.equal 'shippingcity'

    it 'supports arrays', ->
      expect(normalizeSalesforce.denormalize(
        ['id', 'field1', 'ns__field2'], 'customobject'
      )).to.deep.equal(
        ['id', 'field1__c', 'ns__field2__c']
      )

      expect(normalizeSalesforce.denormalize(
        ['tickersymbol', 'field2', 'type', 'ns__field3'], 'account'
      )).to.deep.equal(
        ['tickersymbol', 'field2__c', 'type', 'ns__field3__c']
      )

    it 'supports objects', ->
      object =
        'field1': 'value1'
        'field2': 'value2'
        'ns__field1': 'value3'
        'name': 'value4'

      expect normalizeSalesforce.denormalize(object, 'customobject')
        .to.deep.equal
          'field1__c': 'value1'
          'field2__c': 'value2'
          'ns__field1__c': 'value3'
          'name': 'value4'

    it 'supports nestes objects', ->
      object =
        'field1': 'value1'
        'field2':
          'ns__field1': 'value2'
          'id': 1

      expect normalizeSalesforce.denormalize(object, 'customobject')
        .to.deep.equal
          'field1__c': 'value1'
          'field2__c':
            'ns__field1__c': 'value2'
            'id': 1

  describe '#denormalizeObjectName', ->
    it 'adds __c to the name of a custom object', ->
      expect normalizeSalesforce.denormalizeObjectName('customobject')
        .to.equal 'customobject__c'

    it 'preserves the namespace of custom object', ->
      expect normalizeSalesforce.denormalizeObjectName('ns__customobject')
        .to.equal 'ns__customobject__c'

    it 'keeps standard object names plain', ->
      expect normalizeSalesforce.denormalizeObjectName('account')
        .to.equal 'account'
