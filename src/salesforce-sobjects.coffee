'use strict'

angular.module('angular-normalize-salesforce')
.constant 'ansSalesforceSObjects', {
  account: [
    'masterrecordid',
    'currencyisocode',
    'division',
    'id',
    'accountnumber',
    'ownerid',
    'recordtypeid',
    'site',
    'accountsource',
    'annualrevenue',
    'billingstreet',
    'billingcity',
    'billingstate',
    'billingpostalcode',
    'billingcountry',
    'createdbyid',
    'createddate',
    'jigsaw',
    'isdeleted',
    'description',
    'numberofemployees',
    'isexcludedfromrealign',
    'fax',
    'industry',
    'jigsawcompanyid',
    'lastactivitydate',
    'lastmodifiedbyid',
    'lastmodifieddate',
    'lastreferenceddate',
    'lastvieweddate',
    'ownership',
    'parentid',
    'phone',
    'photourl',
    'rating',
    'connectionreceivedid',
    'sic',
    'sicdesc',
    'connectionsentid',
    'shippingstreet',
    'shippingcity',
    'shippingstate',
    'shippingpostalcode',
    'shippingcountry',
    'systemmodstamp',
    'tickersymbol',
    'type',
    'website'
  ]
  contact: [
    'accountid',
    'assistantname',
    'assistantphone',
    'birthdate',
    'masterrecordid',
    'currencyisocode',
    'division',
    'id',
    'ownerid',
    'createdbyid',
    'createddate',
    'jigsaw',
    'isdeleted',
    'department',
    'description',
    'donotcall',
    'email',
    'emailbounceddate',
    'emailbouncedreason',
    'hasoptedoutofemail',
    'fax',
    'hasoptedoutoffax',
    'homephone',
    'isemailbounced',
    'jigsawcontactid',
    'lastactivitydate',
    'lastmodifiedbyid',
    'lastmodifieddate',
    'lastreferenceddate',
    'lastcurequestdate',
    'lastcuupdatedate',
    'lastvieweddate',
    'leadsource',
    'mailingstreet',
    'mailingcity',
    'mailingstate',
    'mailingpostalcode',
    'mailingcountry',
    'mobilephone',
    'salutation',
    'firstname',
    'lastname',
    'otherstreet',
    'othercity',
    'otherstate',
    'otherpostalcode',
    'othercountry',
    'otherphone',
    'phone',
    'photourl',
    'connectionreceivedid',
    'reportstoid',
    'connectionsentid',
    'systemmodstamp',
    'title'
  ]
  event: [
    'accountid',
    'currencyisocode',
    'id',
    'isalldayevent',
    'isarchived',
    'ownerid',
    'isrecurrence',
    'createdbyid',
    'createddate',
    'activitydate',
    'isdeleted',
    'description',
    'division',
    'durationinminutes',
    'enddatetime',
    'recurrenceenddateonly',
    'groupeventtype',
    'ischild',
    'isgroupevent',
    'lastmodifiedbyid',
    'lastmodifieddate',
    'location',
    'whoid',
    'isprivate',
    'isvisibleinselfservice',
    'recurrenceactivityid',
    'recurrencedayofmonth',
    'recurrencedayofweekmask',
    'recurrenceinstance',
    'recurrenceinterval',
    'recurrencemonthofyear',
    'recurrencetimezonesidkey',
    'recurrencetype',
    'whatid',
    'reminderdatetime',
    'isreminderset',
    'showas',
    'startdatetime',
    'recurrencestartdatetime',
    'subject',
    'systemmodstamp',
    'activitydatetime',
    'type'
  ]
  task: [
    'accountid',
    'currencyisocode',
    'id',
    'isarchived',
    'ownerid',
    'calldurationinseconds',
    'callobject',
    'calldisposition',
    'calltype',
    'isclosed',
    'description',
    'isrecurrence',
    'createdbyid',
    'createddate',
    'isdeleted',
    'division',
    'activitydate',
    'recurrenceenddateonly',
    'lastmodifiedbyid',
    'lastmodifieddate',
    'whoid',
    'priority',
    'isvisibleinselfservice',
    'connectionreceivedid',
    'recurrenceactivityid',
    'recurrencedayofmonth',
    'recurrencedayofweekmask',
    'recurrenceinstance',
    'recurrenceinterval',
    'recurrencemonthofyear',
    'recurrencetimezonesidkey',
    'recurrencetype',
    'whatid',
    'reminderdatetime',
    'isreminderset',
    'recurrenceregeneratedtype',
    'connectionsentid',
    'recurrencestartdateonly',
    'status',
    'subject',
    'systemmodstamp',
    'type'
  ],
  user: [
    'aboutme',
    'accountid',
    'address',
    'alias',
    'badgetext',
    'callcenterid',
    'city',
    'communitynickname',
    'companyname',
    'contactid',
    'country',
    'countrycode',
    'currentstatus',
    'defaultcurrencyisocode',
    'defaultdivision',
    'defaultgroupnotificationfrequency',
    'delegatedapproverid',
    'department',
    'digestfrequency',
    'division',
    'email',
    'emailencodingkey',
    'emailpreferencesautobcc',
    'emailpreferencesautobccstayintouch',
    'emailpreferencesstayintouchreminder',
    'employeenumber',
    'extension',
    'fax',
    'federationidentifier',
    'firstname',
    'forecastenabled',
    'fullphotourl',
    'isactive',
    'ispartner',
    'isportalenabled',
    'isportalselfregistered',
    'isprmsuperuser',
    'jigsawimportlimitoverride',
    'languagelocalekey',
    'lastlogindate',
    'lastname',
    'lastreferenceddate',
    'lastvieweddate',
    'latitude',
    'localesidkey',
    'longitude',
    'manager',
    'managerid',
    'middlename',
    'mobilephone',
    'name',
    'offlinetrialexpirationdate',
    'phone',
    'portalrole',
    'postalcode',
    'profileid',
    'receivesadmininfoemails',
    'receivesinfoemails',
    'senderemail',
    'sendername',
    'signature',
    'smallphotourl',
    'state',
    'statecode',
    'stayintouchnote',
    'stayintouchsignature',
    'stayintouchsubject',
    'street',
    'suffix',
    'timezonesidkey',
    'title',
    'username',
    'userpermissionscallcenterautologin',
    'userpermissionschatteranswersuser',
    'userpermissionsinteractionuser',
    'userpermissionsjigsawprospectinguser',
    'userpermissionsknowledgeuser',
    'userpermissionsliveagentuser',
    'userpermissionsmarketinguser',
    'userpermissionsmobileuser',
    'userpermissionsofflineuser',
    'userpermissionssfcontentuser',
    'userpermissionssiteforcecontributoruser',
    'userpermissionssiteforcepublisheruser',
    'userpermissionssupportuser',
    'userpermissionswirelessuser',
    'userpermissionsworkdotcomuserfeature',
    'userpreferencesactivityreminderspopup',
    'userpreferencesapexpagesdevelopermode',
    'userpreferencescontentemailasandwhen',
    'userpreferencescontentnoemail',
    'userpreferencesenableautosubforfeeds',
    'userpreferencesdisableallfeedsemail',
    'userpreferencesdisableautosubforfeeds',
    'userpreferencesdisablebookmarkemail',
    'userpreferencesdisablechangecommentemail',
    'userpreferencesdisableendorsementemail',
    'userpreferencesdisablefilesharenotificationsforapi',
    'userpreferencesdisablelatercommentemail',
    'userpreferencesdisablelikeemail',
    'userpreferencesdisablementionspostemail',
    'userpreferencesdisableprofilepostemail',
    'userpreferencesdisablesharepostemail',
    'userpreferencesdisablefeedbackemail',
    'userpreferencesdiscommentafterlikeemail',
    'userpreferencesdismentionscommentemail',
    'userpreferencesdisablemessageemail',
    'userpreferencesdisablerewardemail',
    'userpreferencesdisableworkemail',
    'userpreferencesdisprofpostcommentemail',
    'userpreferenceseventreminderscheckboxdefault',
    'userpreferenceshidechatteronboardingsplash',
    'userpreferenceshidecsndesktoptask',
    'userpreferenceshidecsngetchattermobiletask',
    'userpreferenceshidesecondchatteronboardingsplash',
    'userpreferenceshides1browserui',
    'userpreferencesjigsawlistuser',
    'userpreferencesoptoutoftouch',
    'userpreferencesprocessassistantcollapsed',
    'userpreferencesshowcitytoexternalusers',
    'userpreferencesshowcitytoguestusers',
    'userpreferencesshowcountrytoexternalusers',
    'userpreferencesshowcountrytoguestusers',
    'userpreferencesshowemailtoexternalusers',
    'userpreferencesshowfaxtoexternalusers',
    'userpreferencesshowmanagertoexternalusers',
    'userpreferencesshowmobilephonetoexternalusers',
    'userpreferencesshowpostalcodetoexternalusers',
    'userpreferencesshowpostalcodetoguestusers',
    'userpreferencesshowstatetoexternalusers',
    'userpreferencesshowstatetoguestusers',
    'userpreferencesshowstreetaddresstoexternalusers',
    'userpreferencesshowtitletoexternalusers',
    'userpreferencesshowtitletoguestusers',
    'userpreferencesshowworkphonetoexternalusers',
    'userpreferencestaskreminderscheckboxdefault',
    'userroleid',
    'wirelessemail'
  ]
}
