# Angular Normalize Salesforce

[![Build Status](https://travis-ci.org/propertybase/angular-normalize-salesforce.svg)](https://travis-ci.org/propertybase/angular-normalize-salesforce) [![devDependency Status](https://david-dm.org/propertybase/angular-normalize-salesforce/dev-status.svg)](https://david-dm.org/propertybase/angular-normalize-salesforce#info=devDependencies)

Angular module to normalize and denormalize Salesforce fields and object names.

## Installation

Download the `.js` file from the dist folder or use __Bower__

```bash
$ bower install angular-normalize-salesforce --save
```

After including the dist file into your project you have to add the module
as a dependency to your Angular project module:

```javascript
angular.module('myModule', ['angular-normalize-salesforce'])
```

## Usage

The `normalizeSalesforce` service offers 3 main methods:

 * `normalize(part)`<br>
   Supports `string`, `array`, `object`. It removes __c from the string, or all
   strings in the array. If `part` is an object, all keys are normalized.

 * `denormalize(part, sObject)`<br>
   Also supports `string`, `array` and `object`. Needs the name of the sObject
   as a parameter to denormalize only custom fields and keep standard fields
   plain.

 * `denormalizeObjectName(name)`<br>
   Supports only a plain `string`. Adds __c to the given name, if the object
   is not a standard object.<br>
   This is a separate function to allow custom fields with the name of a
   standard object (e.g. `Account__c`)

### sObject Support

In order to support all Salesforce standard objects, all standard fields have
to be defined in the source code. We currently support the standard objects:

 * `Account`
 * `Contact`
 * `Event`
 * `Task`
 * `User`

__If you need more objects (or if there is a change in the Salesforce API)
please send me a Pull Request!__

## Example Usage

```javascript
angular.module('myModule', ['angular-normalize-salesforce']);
angular.module('myModule')
  .factory('exampleFactory', ['normalizeSalesforce', function (normalizeSalesforce) {
    var sObject = {
      'Field1__c': 'value1',
      'field2__c': 'value2',
      'ns__Field1__c': 'value3',
      'Name': 'value4'
    };

    /**
     * Should return
     * {
     *   'field1': 'value1',
     *   'field2': 'value2',
     *   'ns_field1': 'value3',
     *   'name': 'value4'
     * }
     */
    console.log(normalizeSalesforce.normalize(sObject));

    var object = {
      'field1': 'value1',
      'ns__field2': 'value2',
      'name': 'value3'
    }

    /**
     * Should return
     * {
     *   'field1__c': 'value1',
     *   'ns__field2__c': 'value2',
     *   'name': 'value3'
     * }
     */
    console.log(normalizeSalesforce.denormalize(object, 'CustomObject__c'));

    return 'yeah :)';
  }]);
```

## Contributing

### Prepare your environment

 * Install Node.js and NPM
 * Install global dev dependencies: `npm install -g gulp`
 * Install local dev dependencies: `npm install`

### Build

 * Build the whole project with `gulp`
