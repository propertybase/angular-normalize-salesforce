'use strict';
angular.module('angular-normalize-salesforce', []);

'use strict';
angular.module('angular-normalize-salesforce').constant('ansSalesforceStandardFields', ['id', 'isdeleted', 'name', 'createddate', 'createdbyid', 'lastmodifieddate', 'lastmodifiedbyid', 'systemmodstamp', 'lastactivitydate', 'currencyisocode']);

'use strict';
angular.module('angular-normalize-salesforce').constant('ansSalesforceStandardObjects', ["acceptedeventrelation", "account", "accountcontactrole", "accountfeed", "accounthistory", "accountpartner", "accountshare", "activityhistory", "additionalnumber", "aggregateresult", "announcement", "apexclass", "apexcomponent", "apexpage", "apextestqueueitem", "apextestresult", "apextrigger", "appmenuitem", "assignmentrule", "asyncapexjob", "attachedcontentdocument", "attachment", "authsession", "brandtemplate", "businesshours", "businessprocess", "callcenter", "categorynode", "chatteractivity", "clientbrowser", "collaborationgroup", "collaborationgroupfeed", "collaborationgroupmember", "collaborationgroupmemberrequest", "collaborationinvitation", "combinedattachment", "community", "contact", "contactfeed", "contacthistory", "contactshare", "contentdocument", "contentdocumentfeed", "contentdocumenthistory", "contentdocumentlink", "contentversion", "contentversionhistory", "cronjobdetail", "crontrigger", "dashboard", "dashboardcomponent", "dashboardcomponentfeed", "dashboardfeed", "declinedeventrelation", "document", "documentattachmentmap", "domain", "domainsite", "emailservicesaddress", "emailservicesfunction", "emailstatus", "emailtemplate", "entitysubscription", "event", "eventfeed", "eventrelation", "feedcomment", "feeditem", "feedlike", "feedtrackedchange", "fieldpermissions", "fiscalyearsettings", "folder", "forecastshare", "group", "groupmember", "hashtagdefinition", "holiday", "idea", "ideacomment", "loginip", "mailmergetemplate", "mobiledeviceregistrar", "name", "note", "noteandattachment", "objectpermissions", "openactivity", "orgwideemailaddress", "ownedcontentdocument", "period", "permissionset", "permissionsetassignment", "permissionsetlicense", "permissionsetlicenseassign", "processdefinition", "processinstance", "processinstancehistory", "processinstancenode", "processinstancestep", "processinstanceworkitem", "processnode", "profile", "pushtopic", "queuesobject", "recentlyviewed", "recordtype", "report", "reportfeed", "scontrol", "setupentityaccess", "site", "sitefeed", "sitehistory", "staticresource", "task", "taskfeed", "taskpriority", "taskstatus", "topic", "topicassignment", "topicfeed", "undecidedeventrelation", "user", "userfeed", "userlicense", "userpreference", "userprofile", "userrecordaccess", "userrole", "usershare", "vote"]);

'use strict';
angular.module('angular-normalize-salesforce').constant('ansSalesforceSObjects', {
  account: ['masterrecordid', 'currencyisocode', 'division', 'id', 'accountnumber', 'ownerid', 'recordtypeid', 'site', 'accountsource', 'annualrevenue', 'billingstreet', 'billingcity', 'billingstate', 'billingpostalcode', 'billingcountry', 'createdbyid', 'createddate', 'jigsaw', 'isdeleted', 'description', 'numberofemployees', 'isexcludedfromrealign', 'fax', 'industry', 'jigsawcompanyid', 'lastactivitydate', 'lastmodifiedbyid', 'lastmodifieddate', 'lastreferenceddate', 'lastvieweddate', 'ownership', 'parentid', 'phone', 'photourl', 'rating', 'connectionreceivedid', 'sic', 'sicdesc', 'connectionsentid', 'shippingstreet', 'shippingcity', 'shippingstate', 'shippingpostalcode', 'shippingcountry', 'systemmodstamp', 'tickersymbol', 'type', 'website'],
  task: ['accountid', 'currencyisocode', 'id', 'isarchived', 'ownerid', 'calldurationinseconds', 'callobject', 'calldisposition', 'calltype', 'isclosed', 'description', 'isrecurrence', 'createdbyid', 'createddate', 'isdeleted', 'division', 'activitydate', 'recurrenceenddateonly', 'lastmodifiedbyid', 'lastmodifieddate', 'whoid', 'priority', 'isvisibleinselfservice', 'connectionreceivedid', 'recurrenceactivityid', 'recurrencedayofmonth', 'recurrencedayofweekmask', 'recurrenceinstance', 'recurrenceinterval', 'recurrencemonthofyear', 'recurrencetimezonesidkey', 'recurrencetype', 'whatid', 'reminderdatetime', 'isreminderset', 'recurrenceregeneratedtype', 'connectionsentid', 'recurrencestartdateonly', 'status', 'subject', 'systemmodstamp', 'type']
});

'use strict';
var NormalizeSalesforce,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('angular-normalize-salesforce').service('normalizeSalesforce', NormalizeSalesforce = (function() {
  function NormalizeSalesforce(ansSalesforceSObjects, ansSalesforceStandardObjects, ansSalesforceStandardFields) {
    this._denormalizeObject = __bind(this._denormalizeObject, this);
    this._denormalizeArray = __bind(this._denormalizeArray, this);
    this._denormalizeString = __bind(this._denormalizeString, this);
    this.denormalizeObjectName = __bind(this.denormalizeObjectName, this);
    this.denormalize = __bind(this.denormalize, this);
    this._normalizeObject = __bind(this._normalizeObject, this);
    this._normalizeArray = __bind(this._normalizeArray, this);
    this.normalize = __bind(this.normalize, this);
    this.standardFields = ansSalesforceStandardFields;
    this.standardObjects = ansSalesforceStandardObjects;
    this.sObjectFields = ansSalesforceSObjects;
  }

  NormalizeSalesforce.prototype.normalize = function(part) {
    var type_name;
    type_name = Object.prototype.toString.call(part);
    switch (false) {
      case !_(part).isString():
        return this._normalizeString(part);
      case !_(part).isArray():
        return this._normalizeArray(part);
      case !_(part).isObject():
        return this._normalizeObject(part);
      default:
        throw new Error("Type " + type_name + " not supported. Only String, Array and Object are supported.");
    }
  };

  NormalizeSalesforce.prototype._normalizeString = function(string) {
    return string.toLowerCase().replace('__c', '');
  };

  NormalizeSalesforce.prototype._normalizeArray = function(array) {
    return _.map(array, (function(_this) {
      return function(element) {
        return _this.normalize(element);
      };
    })(this));
  };

  NormalizeSalesforce.prototype._normalizeObject = function(object) {
    var normalized;
    normalized = {};
    _(object).forEach((function(_this) {
      return function(value, key) {
        if (_(value).isObject() && !_(value).isFunction()) {
          return normalized[_this.normalize(key)] = _this.normalize(value);
        } else {
          return normalized[_this.normalize(key)] = value;
        }
      };
    })(this));
    return normalized;
  };

  NormalizeSalesforce.prototype.denormalize = function(part, sObject) {
    var type_name;
    type_name = Object.prototype.toString.call(part);
    switch (false) {
      case !_(part).isString():
        return this._denormalizeString(part, sObject);
      case !_(part).isArray():
        return this._denormalizeArray(part, sObject);
      case !_(part).isObject():
        return this._denormalizeObject(part, sObject);
      default:
        throw new Error("Type " + type_name + " not supported. Only String, Array and Object are supported.");
    }
  };

  NormalizeSalesforce.prototype.denormalizeObjectName = function(name) {
    return this._denormalize(name, this.standardObjects);
  };

  NormalizeSalesforce.prototype._denormalize = function(part, avoidList) {
    if (!_(avoidList).contains(part)) {
      return "" + part + "__c";
    } else {
      return part;
    }
  };

  NormalizeSalesforce.prototype._denormalizeString = function(string, sObject) {
    var standardFields;
    sObject = this.normalize(sObject);
    standardFields = this.standardFields;
    if (_(this.sObjectFields).has(sObject)) {
      standardFields = _.uniq(standardFields.concat(this.sObjectFields[sObject]));
    }
    return this._denormalize(string, standardFields);
  };

  NormalizeSalesforce.prototype._denormalizeArray = function(array, sObject) {
    return _.map(array, (function(_this) {
      return function(element) {
        return _this.denormalize(element, sObject);
      };
    })(this));
  };

  NormalizeSalesforce.prototype._denormalizeObject = function(object, sObject) {
    var denormalized;
    denormalized = {};
    _(object).forEach((function(_this) {
      return function(value, key) {
        if (_(value).isObject() && !_(value).isFunction()) {
          return denormalized[_this.denormalize(key, sObject)] = _this.denormalize(value, sObject);
        } else {
          return denormalized[_this.denormalize(key, sObject)] = value;
        }
      };
    })(this));
    return denormalized;
  };

  return NormalizeSalesforce;

})());

//# sourceMappingURL=angular-normalize-salesforce.js.map