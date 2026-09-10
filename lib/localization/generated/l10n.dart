import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ar.dart';
import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of GeniusLinkLocalization
/// returned by `GeniusLinkLocalization.of(context)`.
///
/// Applications need to include `GeniusLinkLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: GeniusLinkLocalization.localizationsDelegates,
///   supportedLocales: GeniusLinkLocalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the GeniusLinkLocalization.supportedLocales
/// property.
abstract class GeniusLinkLocalization {
  GeniusLinkLocalization(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static GeniusLinkLocalization of(BuildContext context) {
    return Localizations.of<GeniusLinkLocalization>(
      context,
      GeniusLinkLocalization,
    )!;
  }

  static const LocalizationsDelegate<GeniusLinkLocalization> delegate =
      _GeniusLinkLocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Title of the account detail screen.
  ///
  /// In en, this message translates to:
  /// **'Account Detail'**
  String get accountDetail;

  /// Label indicating that an account is active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Section title for the account current balance.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get currentBalance;

  /// Section title for account information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// Label for an account code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// Label for the account type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get accountType;

  /// Display value for an asset cash account type.
  ///
  /// In en, this message translates to:
  /// **'Asset · Cash'**
  String get assetCash;

  /// Label for the account hierarchy/tree.
  ///
  /// In en, this message translates to:
  /// **'Tree'**
  String get tree;

  /// Display name of the sample assets tree.
  ///
  /// In en, this message translates to:
  /// **'Assets Tree (1)'**
  String get assetsTreeOne;

  /// Label for currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// Section title for recent account transactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// Button label that returns to the accounts list.
  ///
  /// In en, this message translates to:
  /// **'Back to List'**
  String get backToList;

  /// Prefix shown before the balance as-of date and time.
  ///
  /// In en, this message translates to:
  /// **'As of'**
  String get asOf;

  /// Label for total debit amount.
  ///
  /// In en, this message translates to:
  /// **'Total Debits'**
  String get totalDebits;

  /// Label for total credit amount.
  ///
  /// In en, this message translates to:
  /// **'Total Credits'**
  String get totalCredits;

  /// Section title for account information.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// Display label for the cash equivalents account type.
  ///
  /// In en, this message translates to:
  /// **'Asset · Cash Equivalents'**
  String get assetCashEquivalents;

  /// Label for an English name field.
  ///
  /// In en, this message translates to:
  /// **'Name English'**
  String get nameEnglish;

  /// Label for an Arabic name field.
  ///
  /// In en, this message translates to:
  /// **'Name Arabic'**
  String get nameArabic;

  /// Label or title for the account tree.
  ///
  /// In en, this message translates to:
  /// **'Account Tree'**
  String get accountTree;

  /// Label for the parent account group.
  ///
  /// In en, this message translates to:
  /// **'Parent Group'**
  String get parentGroup;

  /// Label for a tenant identifier.
  ///
  /// In en, this message translates to:
  /// **'Tenant ID'**
  String get tenantId;

  /// Subtitle for the recent transactions section.
  ///
  /// In en, this message translates to:
  /// **'Latest entries · running balance'**
  String get latestEntriesRunningBalance;

  /// Short balance label shown beside a running transaction balance.
  ///
  /// In en, this message translates to:
  /// **'Bal'**
  String get balanceShort;

  /// Section title for audit information.
  ///
  /// In en, this message translates to:
  /// **'Audit Information'**
  String get auditInformation;

  /// Audit action label for creation.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// Audit action label for modification.
  ///
  /// In en, this message translates to:
  /// **'Modified'**
  String get modified;

  /// Button label for export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// Generic back button label.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Title for the chart of accounts.
  ///
  /// In en, this message translates to:
  /// **'Chart of Accounts'**
  String get chartOfAccounts;

  /// Subtitle describing the account tree.
  ///
  /// In en, this message translates to:
  /// **'Roll-up balances · bilingual'**
  String get rollUpBalancesBilingual;

  /// Account column label.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Balance column label using SAR.
  ///
  /// In en, this message translates to:
  /// **'Balance (SAR)'**
  String get balanceSar;

  /// Accounts screen title.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// Placeholder shown for account search.
  ///
  /// In en, this message translates to:
  /// **'Search accounts…'**
  String get searchAccounts;

  /// Create account screen title.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Section title for account creation details.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get accountDetails;

  /// Subtitle for account creation details.
  ///
  /// In en, this message translates to:
  /// **'Identify and place in the tree'**
  String get identifyAndPlaceInTree;

  /// Label for the account code input.
  ///
  /// In en, this message translates to:
  /// **'Account Code'**
  String get accountCode;

  /// Example placeholder for an account code.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1102'**
  String get example1102;

  /// Display label for an asset account type.
  ///
  /// In en, this message translates to:
  /// **'Asset'**
  String get asset;

  /// Example placeholder for an English account name.
  ///
  /// In en, this message translates to:
  /// **'e.g. Bank · Al Rajhi'**
  String get exampleEnglishAccountName;

  /// Example placeholder for an Arabic account name.
  ///
  /// In en, this message translates to:
  /// **'e.g. Al Rajhi Bank'**
  String get exampleArabicAccountName;

  /// Placeholder for searching parent account groups.
  ///
  /// In en, this message translates to:
  /// **'Search a parent group…'**
  String get searchParentGroup;

  /// Settings section title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Placeholder for currency search.
  ///
  /// In en, this message translates to:
  /// **'Search currency…'**
  String get searchCurrency;

  /// Label for opening balance.
  ///
  /// In en, this message translates to:
  /// **'Opening Balance'**
  String get openingBalance;

  /// Label for normal debit or credit balance.
  ///
  /// In en, this message translates to:
  /// **'Normal Balance'**
  String get normalBalance;

  /// Debit option label.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get debit;

  /// Credit option label.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// Cancel button label.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Create button label.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Create account group screen title.
  ///
  /// In en, this message translates to:
  /// **'Create Account Group'**
  String get createAccountGroup;

  /// Section title for group creation details.
  ///
  /// In en, this message translates to:
  /// **'Group Details'**
  String get groupDetails;

  /// Subtitle for group name and tree association.
  ///
  /// In en, this message translates to:
  /// **'Name and tree association'**
  String get nameAndTreeAssociation;

  /// Example placeholder for an account group name.
  ///
  /// In en, this message translates to:
  /// **'e.g. Current Assets'**
  String get exampleCurrentAssets;

  /// Placeholder for selecting an account tree.
  ///
  /// In en, this message translates to:
  /// **'Select a tree…'**
  String get selectTree;

  /// Additional information section title.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInformation;

  /// Label for a note field.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// Placeholder for group notes.
  ///
  /// In en, this message translates to:
  /// **'Add any notes about this group…'**
  String get addNotesAboutGroup;

  /// Group detail screen title.
  ///
  /// In en, this message translates to:
  /// **'Group Detail'**
  String get groupDetail;

  /// Section title for group information.
  ///
  /// In en, this message translates to:
  /// **'Group Information'**
  String get groupInformation;

  /// Generic identifier label.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// Notes section title.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// Audit section title.
  ///
  /// In en, this message translates to:
  /// **'Audit'**
  String get audit;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Invite User'**
  String get inviteUser;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get identity;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'The new member\'\'s name and contact'**
  String get theNewMemberSNameAndContact;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Omar Hassan'**
  String get eGOmarHassan;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Work Email'**
  String get workEmail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Employee ID'**
  String get employeeId;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Access'**
  String get access;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Role determines default permissions'**
  String get roleDeterminesDefaultPermissions;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Default Store'**
  String get defaultStore;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'An invitation email with a single-use setup link will be sent. The account stays Pending until the user sets a password.'**
  String
  get anInvitationEmailWithASingleUseSetupLinkWillBeSentTheAccountStaysPendingUntilTheUserSetsAPassword;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Send Invitation'**
  String get sendInvitation;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'User Detail'**
  String get userDetail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Authentication'**
  String get twoFactorAuthentication;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Active Sessions'**
  String get activeSessions;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Devices currently signed in'**
  String get devicesCurrentlySignedIn;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Revoke'**
  String get revoke;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Deactivate User'**
  String get deactivateUser;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Access your workspace'**
  String get accessYourWorkspace;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Sign In to GeniusLink'**
  String get signInToGeniusLink;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Sessions are recorded in the audit log with timestamp and device.'**
  String get sessionsAreRecordedInTheAuditLogWithTimestampAndDevice;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Provision a workspace'**
  String get provisionAWorkspace;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'You\'\'ll be the workspace administrator.'**
  String get youLlBeTheWorkspaceAdministrator;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Khalid Al-Rashid'**
  String get eGKhalidAlRashid;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Al-Rashid Trading Co.'**
  String get eGAlRashidTradingCo;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Data Processing Agreement.'**
  String get iAgreeToTheTermsOfServiceAndDataProcessingAgreement;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Create Workspace'**
  String get createWorkspace;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword2;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Enter the email tied to your account.'**
  String get enterTheEmailTiedToYourAccount;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToSignIn;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox'**
  String get checkYourInbox;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Use a different email'**
  String get useADifferentEmail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Create Deposit'**
  String get createDeposit;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Deposit Amount'**
  String get depositAmount;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Deposit To'**
  String get depositTo;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Counter slip no.'**
  String get eGCounterSlipNo;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Value Date'**
  String get valueDate;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Journal Preview'**
  String get journalPreview;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Optional note for this deposit…'**
  String get optionalNoteForThisDeposit;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Create External Transfer'**
  String get createExternalTransfer;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Transfer Amount'**
  String get transferAmount;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'FX Conversion'**
  String get fxConversion;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary'**
  String get beneficiary;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'IBAN / SWIFT'**
  String get ibanSwift;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Purpose Code'**
  String get purposeCode;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'External wires settle in 1–2 business days and require dual approval.'**
  String get externalWiresSettleIn12BusinessDaysAndRequireDualApproval;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Create Local Transfer'**
  String get createLocalTransfer;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'To Account'**
  String get toAccount;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Internal note / slip no.'**
  String get internalNoteSlipNo;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Create Withdrawal'**
  String get createWithdrawal;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Amount'**
  String get withdrawalAmount;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Withdraw From'**
  String get withdrawFrom;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Payee'**
  String get payee;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Global Steel Imports'**
  String get eGGlobalSteelImports;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Expense Account'**
  String get expenseAccount;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Withdrawals above 10,000 SAR require a second approval before posting.'**
  String get withdrawalsAbove10000SarRequireASecondApprovalBeforePosting;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Deposit Receipt'**
  String get depositReceipt;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Posted Journal'**
  String get postedJournal;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'External Wire Detail'**
  String get externalWireDetail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'External Wire'**
  String get externalWire;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get posted;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Inter-Account Settlement'**
  String get interAccountSettlement;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Transferred'**
  String get transferred;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Voucher'**
  String get withdrawalVoucher;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Add Currency'**
  String get addCurrency;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Currency Definition'**
  String get currencyDefinition;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'ISO code, display names and symbol'**
  String get isoCodeDisplayNamesAndSymbol;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'ISO Code'**
  String get isoCode;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. USD'**
  String get eGUsd;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Symbol'**
  String get symbol;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. US Dollar'**
  String get eGUsDollar;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Precision & Rate'**
  String get precisionRate;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Decimal places and exchange rate against base'**
  String get decimalPlacesAndExchangeRateAgainstBase;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Decimal Places'**
  String get decimalPlaces;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate (per 1 SAR)'**
  String get exchangeRatePer1Sar;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. 3.750200'**
  String get eG3750200;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Set as base currency'**
  String get setAsBaseCurrency;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Currencies'**
  String get currencies;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Currency Detail'**
  String get currencyDetail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Current Rate'**
  String get currentRate;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Per 1 base currency'**
  String get per1BaseCurrency;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Definition'**
  String get definition;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Localized Name'**
  String get localizedName;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Rate History'**
  String get rateHistory;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Recent updates'**
  String get recentUpdates;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'No rate history available.'**
  String get noRateHistoryAvailable;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rates'**
  String get exchangeRates;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Base Currency'**
  String get baseCurrency;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Pull ECB Feed'**
  String get pullEcbFeed;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Rates per 1 SAR'**
  String get ratesPer1Sar;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Auto-fed pairs sync daily; manual pairs are editable'**
  String get autoFedPairsSyncDailyManualPairsAreEditable;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Fiscal Year'**
  String get fiscalYear;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Define the active fiscal year boundaries'**
  String get defineTheActiveFiscalYearBoundaries;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Accounting Periods'**
  String get accountingPeriods;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'12 monthly periods · lock to prevent back-dated postings'**
  String get text12MonthlyPeriodsLockToPreventBackDatedPostings;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Closing a period locks all postings dated within it. A locked period can only be reopened by a controller with audit justification.'**
  String
  get closingAPeriodLocksAllPostingsDatedWithinItALockedPeriodCanOnlyBeReopenedByAControllerWithAuditJusti;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Contact Person'**
  String get contactPerson;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Control Account'**
  String get controlAccount;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Payment Terms'**
  String get paymentTerms;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Recent invoices and payments'**
  String get recentInvoicesAndPayments;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Legal name and contact details'**
  String get legalNameAndContactDetails;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Riyadh Construction Co.'**
  String get eGRiyadhConstructionCo;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ahmed K.'**
  String get eGAhmedK;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Riyadh'**
  String get eGRiyadh;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Linked control account and terms'**
  String get linkedControlAccountAndTerms;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Tax / VAT Number'**
  String get taxVatNumber;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Credit Limit (SAR)'**
  String get creditLimitSar;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. 100,000.00'**
  String get eG10000000;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'In'**
  String get inflowShort;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Out'**
  String get outflowShort;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Cash Flow'**
  String get cashFlow;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Inflow vs outflow · SAR thousands · 12 months'**
  String get inflowVsOutflowSarThousands12Months;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Cash & Asset Accounts'**
  String get cashAssetAccounts;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Top balances'**
  String get topBalances;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Recent Operations'**
  String get recentOperations;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Needs Attention'**
  String get needsAttention;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Inventory Adjustment'**
  String get inventoryAdjustment;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Adjustment Details'**
  String get adjustmentDetails;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Serial No'**
  String get serialNo;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Search store…'**
  String get searchStore;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Count Date'**
  String get countDate;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Variance Summary'**
  String get varianceSummary;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Net financial impact of this reconciliation'**
  String get netFinancialImpactOfThisReconciliation;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Net Adjustment'**
  String get netAdjustment;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Adjustment Lines'**
  String get adjustmentLines;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Documentation & Approval'**
  String get documentationApproval;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Adjustment Notes'**
  String get adjustmentNotes;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Auditor name, witness, count session reference…'**
  String get auditorNameWitnessCountSessionReference;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Adjustments above 1,000 SAR require dual approval. This entry posts to the audit log immediately and notifies the controller.'**
  String
  get adjustmentsAbove1000SarRequireDualApprovalThisEntryPostsToTheAuditLogImmediatelyAndNotifiesTheContro;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Barcode Print'**
  String get barcodePrint;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Label Template'**
  String get labelTemplate;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Symbology'**
  String get symbology;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Paper'**
  String get paper;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Copies per Item'**
  String get copiesPerItem;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Queue'**
  String get queue;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Category Tree'**
  String get categoryTree;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'5 top-level groups'**
  String get text5TopLevelGroups;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'New Category'**
  String get newCategory;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Quick inline form'**
  String get quickInlineForm;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. CAT-006'**
  String get eGCat006;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get parent;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Adhesives & Sealants'**
  String get eGAdhesivesSealants;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Adhesives'**
  String get eGAdhesives;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Create Product'**
  String get createProduct;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Product Definition'**
  String get productDefinition;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'SKU, names and classification'**
  String get skuNamesAndClassification;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. STL-44021'**
  String get eGStl44021;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get barcode;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Scan or type'**
  String get scanOrType;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Structural Steel I-Beam'**
  String get eGStructuralSteelIBeam;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Select category…'**
  String get selectCategory;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Unit of Measure'**
  String get unitOfMeasure;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Select unit…'**
  String get selectUnit;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Costing & Pricing'**
  String get costingPricing;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Unit Cost (SAR)'**
  String get unitCostSar;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Selling Price (SAR)'**
  String get sellingPriceSar;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'VAT Rate'**
  String get vatRate;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Select rate…'**
  String get selectRate;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Inventory Settings'**
  String get inventorySettings;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Reorder Level'**
  String get reorderLevel;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Select store…'**
  String get selectStore;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Opening Stock'**
  String get openingStock;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Product Images'**
  String get productImages;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Reorder Alerts'**
  String get reorderAlerts;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'3 products at or below reorder level'**
  String get text3ProductsAtOrBelowReorderLevel;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Generate Purchase Order'**
  String get generatePurchaseOrder;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Issue Detail'**
  String get issueDetail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Issued Value'**
  String get issuedValue;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Issue Information'**
  String get issueInformation;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Accounting Distribution'**
  String get accountingDistribution;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Back to Operations'**
  String get backToOperations;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Price Lists'**
  String get priceLists;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Item Prices'**
  String get itemPrices;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Product Detail'**
  String get productDetail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Stock Summary'**
  String get stockSummary;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Aggregated across all stores'**
  String get aggregatedAcrossAllStores;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Total On Hand'**
  String get totalOnHand;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Stock Value'**
  String get stockValue;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Avg Unit Cost'**
  String get avgUnitCost;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Product Information'**
  String get productInformation;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Selling Price'**
  String get sellingPrice;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Stock by Store'**
  String get stockByStore;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Recent Movements'**
  String get recentMovements;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Back to Products'**
  String get backToProducts;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Search product or SKU…'**
  String get searchProductOrSku;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Receive Inventory'**
  String get receiveInventory;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Receive Details'**
  String get receiveDetails;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Select currency…'**
  String get selectCurrency;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Receiving Store'**
  String get receivingStore;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Supplier Account'**
  String get supplierAccount;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. ABC Trading Co.'**
  String get eGAbcTradingCo;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Inventory Items'**
  String get inventoryItems;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Receipt Notes'**
  String get receiptNotes;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'PO number, delivery note, inspection results…'**
  String get poNumberDeliveryNoteInspectionResults;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Receive Detail'**
  String get receiveDetail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Received Value'**
  String get receivedValue;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Receipt Information'**
  String get receiptInformation;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get supplier;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'PO Reference'**
  String get poReference;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'2 lines · 432 units'**
  String get text2Lines432Units;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'COUNT'**
  String get count;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Stock Take'**
  String get stockTake;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'3 of 6 counted'**
  String get text3Of6Counted;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get match;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Short'**
  String get short;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Over'**
  String get over;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Count Sheet'**
  String get countSheet;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Transfer Inventory'**
  String get transferInventory;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Transfer Details'**
  String get transferDetails;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Search origin warehouse…'**
  String get searchOriginWarehouse;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'To Store'**
  String get toStore;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Search destination…'**
  String get searchDestination;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Enter transfer notes or internal instructions…'**
  String get enterTransferNotesOrInternalInstructions;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Transfer Detail'**
  String get transferDetail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Items in Transit'**
  String get itemsInTransit;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'2 lines · 258 units'**
  String get text2Lines258Units;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Logistics & Tracking'**
  String get logisticsTracking;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Carrier'**
  String get carrier;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Expected Arrival'**
  String get expectedArrival;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Stock Transfers'**
  String get stockTransfers;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Units of Measure'**
  String get unitsOfMeasure;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Base'**
  String get base;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Warehouses'**
  String get warehouses;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'5 Warehouses'**
  String get text5Warehouses;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Capacity & assigned manager'**
  String get capacityAssignedManager;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Create Journal Entry'**
  String get createJournalEntry;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Entry Header'**
  String get entryHeader;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Describe this journal entry…'**
  String get describeThisJournalEntry;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Journal Lines'**
  String get journalLines;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Journal Entry Detail'**
  String get journalEntryDetail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Journal Entry'**
  String get journalEntry;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get lines;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Back to Entries'**
  String get backToEntries;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Journal Entries'**
  String get journalEntries;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Search entries…'**
  String get searchEntries;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'No entries match.'**
  String get noEntriesMatch;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Financial Operation'**
  String get financialOperation;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Operation Summary'**
  String get operationSummary;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get difference;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Ledger Lines'**
  String get ledgerLines;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Operation created'**
  String get operationCreated;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Submitted for review'**
  String get submittedForReview;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Approved & posted'**
  String get approvedPosted;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Opening Journal'**
  String get openingJournal;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Entry Details'**
  String get entryDetails;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Transfer Lines'**
  String get transferLines;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Create Entry'**
  String get createEntry;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Search every screen…'**
  String get searchEveryScreen;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Audit Log'**
  String get auditLog;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Immutable Activity Trail'**
  String get immutableActivityTrail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Every state-changing action · 7-year retention'**
  String get everyStateChangingAction7YearRetention;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Search entity or user…'**
  String get searchEntityOrUser;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'No log entries match.'**
  String get noLogEntriesMatch;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Balance Sheet'**
  String get balanceSheet;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Balance Check'**
  String get balanceCheck;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Income Statement'**
  String get incomeStatement;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Net Income'**
  String get netIncome;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Inventory Valuation'**
  String get inventoryValuation;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get method;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Weighted Avg'**
  String get weightedAvg;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Stock Valuation'**
  String get stockValuation;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Quantity × weighted-average unit cost'**
  String get quantityWeightedAverageUnitCost;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Search SKU, product or store…'**
  String get searchSkuProductOrStore;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Total Inventory Value'**
  String get totalInventoryValue;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Trial Balance'**
  String get trialBalance;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'All Accounts'**
  String get allAccounts;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Debit & credit balances as of period end'**
  String get debitCreditBalancesAsOfPeriodEnd;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Totals · balanced'**
  String get totalsBalanced;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get billing;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'CURRENT'**
  String get current;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Recent Invoices'**
  String get recentInvoices;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Branches & Stores'**
  String get branchesStores;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Add Branch'**
  String get addBranch;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Company Profile'**
  String get companyProfile;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Names shown on documents'**
  String get namesShownOnDocuments;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Upload Logo'**
  String get uploadLogo;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Legal Name (English)'**
  String get legalNameEnglish;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Legal Name'**
  String get legalName;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Trade Name'**
  String get tradeName;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Commercial Registration'**
  String get commercialRegistration;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Registered Address'**
  String get registeredAddress;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddress;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Postal Code'**
  String get postalCode;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Tax Registration'**
  String get taxRegistration;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'VAT Number'**
  String get vatNumber;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Tax Identification No.'**
  String get taxIdentificationNo;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Tax Authority'**
  String get taxAuthority;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Auto pairs sync daily; manual editable'**
  String get autoPairsSyncDailyManualEditable;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Save Rates'**
  String get saveRates;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Numbering'**
  String get numbering;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Document Sequences'**
  String get documentSequences;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Format: PREFIX-YEAR-NUMBER'**
  String get formatPrefixYearNumber;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Roles List'**
  String get rolesList;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Edit Role'**
  String get editRole;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'New Role'**
  String get newRole;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Workspaces'**
  String get workspaces;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current2;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Manage Workspace'**
  String get manageWorkspace;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Switch to this Workspace'**
  String get switchToThisWorkspace;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'New Workspace'**
  String get newWorkspace;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Create Store'**
  String get createStore;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Store Details'**
  String get storeDetails;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Name and location'**
  String get nameAndLocation;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'e.g. Downtown Central Store'**
  String get eGDowntownCentralStore;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Location Code'**
  String get locationCode;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Store Category'**
  String get storeCategory;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Add internal notes…'**
  String get addInternalNotes;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Issue Inventory'**
  String get issueInventory;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Issue Details'**
  String get issueDetails;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'1 line · 12 units'**
  String get text1Line12Units;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Total Value'**
  String get totalValue;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Store Detail'**
  String get storeDetail;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Stock On Hand'**
  String get stockOnHand;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'No stock items available.'**
  String get noStockItemsAvailable;

  /// Localized user-interface text.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get stores;

  /// Mobile Dashboard user-facing text: Workspace
  ///
  /// In en, this message translates to:
  /// **'Workspace'**
  String get mobileDashboardWorkspace;

  /// Mobile Dashboard user-facing text: Notifications
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get mobileDashboardNotifications;

  /// Mobile Dashboard user-facing text: Overview
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get mobileDashboardOverview;

  /// Mobile Dashboard user-facing text: Sales
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get mobileDashboardSales;

  /// Mobile Dashboard user-facing text: Transfers
  ///
  /// In en, this message translates to:
  /// **'Transfers'**
  String get mobileDashboardTransfers;

  /// Mobile Dashboard user-facing text: Ledger
  ///
  /// In en, this message translates to:
  /// **'Ledger'**
  String get mobileDashboardLedger;

  /// Mobile Dashboard user-facing text: Reports
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get mobileDashboardReports;

  /// Mobile Dashboard user-facing text: Saudi Riyal
  ///
  /// In en, this message translates to:
  /// **'Saudi Riyal'**
  String get mobileDashboardSaudiRiyal;

  /// Mobile Dashboard user-facing text: US Dollar
  ///
  /// In en, this message translates to:
  /// **'US Dollar'**
  String get mobileDashboardUsDollar;

  /// Mobile Dashboard user-facing text: UAE Dirham
  ///
  /// In en, this message translates to:
  /// **'UAE Dirham'**
  String get mobileDashboardUaeDirham;

  /// Mobile Dashboard user-facing text: Tenant 9
  ///
  /// In en, this message translates to:
  /// **'Tenant 9'**
  String get mobileDashboardTenant9;

  /// Mobile Dashboard user-facing text: Tenant 14
  ///
  /// In en, this message translates to:
  /// **'Tenant 14'**
  String get mobileDashboardTenant14;

  /// Mobile Dashboard user-facing text: Tenant 22
  ///
  /// In en, this message translates to:
  /// **'Tenant 22'**
  String get mobileDashboardTenant22;

  /// Mobile Dashboard user-facing text: Out-of-balance entries
  ///
  /// In en, this message translates to:
  /// **'Out-of-balance entries'**
  String get mobileDashboardOutOfBalanceEntries;

  /// Mobile Dashboard user-facing text: Debits and credits don''t match
  ///
  /// In en, this message translates to:
  /// **'Debits and credits don\'\'t match'**
  String get mobileDashboardDebitsAndCreditsDonTMatch;

  /// Mobile Dashboard user-facing text: Pending approvals
  ///
  /// In en, this message translates to:
  /// **'Pending approvals'**
  String get mobileDashboardPendingApprovals;

  /// Mobile Dashboard user-facing text: Vouchers awaiting your sign-off
  ///
  /// In en, this message translates to:
  /// **'Vouchers awaiting your sign-off'**
  String get mobileDashboardVouchersAwaitingYourSignOff;

  /// Mobile Dashboard user-facing text: Sync conflict
  ///
  /// In en, this message translates to:
  /// **'Sync conflict'**
  String get mobileDashboardSyncConflict;

  /// Mobile Dashboard user-facing text: A draft edited on two devices
  ///
  /// In en, this message translates to:
  /// **'A draft edited on two devices'**
  String get mobileDashboardADraftEditedOnTwoDevices;

  /// Mobile Dashboard user-facing text: Banking
  ///
  /// In en, this message translates to:
  /// **'Banking'**
  String get mobileDashboardBanking;

  /// Mobile Dashboard user-facing text: Total Balance
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get mobileDashboardTotalBalance;

  /// Mobile Dashboard user-facing text: Available Cash
  ///
  /// In en, this message translates to:
  /// **'Available Cash'**
  String get mobileDashboardAvailableCash;

  /// Mobile Dashboard user-facing text: Inflow
  ///
  /// In en, this message translates to:
  /// **'Inflow'**
  String get mobileDashboardInflow;

  /// Mobile Dashboard user-facing text: Outflow
  ///
  /// In en, this message translates to:
  /// **'Outflow'**
  String get mobileDashboardOutflow;

  /// Mobile Dashboard user-facing text: Deposit
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get mobileDashboardDeposit;

  /// Mobile Dashboard user-facing text: Withdrawal
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get mobileDashboardWithdrawal;

  /// Mobile Dashboard user-facing text: Transfer
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get mobileDashboardTransfer;

  /// Mobile Dashboard user-facing text: Statement
  ///
  /// In en, this message translates to:
  /// **'Statement'**
  String get mobileDashboardStatement;

  /// Mobile Dashboard user-facing text: Beneficiaries
  ///
  /// In en, this message translates to:
  /// **'Beneficiaries'**
  String get mobileDashboardBeneficiaries;

  /// Mobile Dashboard user-facing text: Reconcile
  ///
  /// In en, this message translates to:
  /// **'Reconcile'**
  String get mobileDashboardReconcile;

  /// Mobile Dashboard user-facing text: Cards
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get mobileDashboardCards;

  /// Mobile Dashboard user-facing text: Cheques
  ///
  /// In en, this message translates to:
  /// **'Cheques'**
  String get mobileDashboardCheques;

  /// Mobile Dashboard user-facing text: Bank Accounts
  ///
  /// In en, this message translates to:
  /// **'Bank Accounts'**
  String get mobileDashboardBankAccounts;

  /// Mobile Dashboard user-facing text: Cash deposit — Main
  ///
  /// In en, this message translates to:
  /// **'Cash deposit — Main'**
  String get mobileDashboardCashDepositMain;

  /// Mobile Dashboard user-facing text: 1h ago
  ///
  /// In en, this message translates to:
  /// **'1h ago'**
  String get mobileDashboardText1hAgo;

  /// Mobile Dashboard user-facing text: Payroll release
  ///
  /// In en, this message translates to:
  /// **'Payroll release'**
  String get mobileDashboardPayrollRelease;

  /// Mobile Dashboard user-facing text: 4h ago
  ///
  /// In en, this message translates to:
  /// **'4h ago'**
  String get mobileDashboardText4hAgo;

  /// Mobile Dashboard user-facing text: Riyad Bank → Main
  ///
  /// In en, this message translates to:
  /// **'Riyad Bank → Main'**
  String get mobileDashboardRiyadBankMain;

  /// Mobile Dashboard user-facing text: Yesterday
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get mobileDashboardYesterday;

  /// Mobile Dashboard user-facing text: Supplier wire
  ///
  /// In en, this message translates to:
  /// **'Supplier wire'**
  String get mobileDashboardSupplierWire;

  /// Mobile Dashboard user-facing text: Customer settlement
  ///
  /// In en, this message translates to:
  /// **'Customer settlement'**
  String get mobileDashboardCustomerSettlement;

  /// Mobile Dashboard user-facing text: 2 days ago
  ///
  /// In en, this message translates to:
  /// **'2 days ago'**
  String get mobileDashboardText2DaysAgo;

  /// Mobile Dashboard user-facing text: Accounting
  ///
  /// In en, this message translates to:
  /// **'Accounting'**
  String get mobileDashboardAccounting;

  /// Mobile Dashboard user-facing text: Total Assets
  ///
  /// In en, this message translates to:
  /// **'Total Assets'**
  String get mobileDashboardTotalAssets;

  /// Mobile Dashboard user-facing text: Cash
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get mobileDashboardCash;

  /// Mobile Dashboard user-facing text: Revenue MTD
  ///
  /// In en, this message translates to:
  /// **'Revenue MTD'**
  String get mobileDashboardRevenueMtd;

  /// Mobile Dashboard user-facing text: Voucher
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get mobileDashboardVoucher;

  /// Mobile Dashboard user-facing text: Receipt
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get mobileDashboardReceipt;

  /// Mobile Dashboard user-facing text: Invoice
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get mobileDashboardInvoice;

  /// Mobile Dashboard user-facing text: Customers
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get mobileDashboardCustomers;

  /// Mobile Dashboard user-facing text: Suppliers
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get mobileDashboardSuppliers;

  /// Mobile Dashboard user-facing text: Fixed Assets
  ///
  /// In en, this message translates to:
  /// **'Fixed Assets'**
  String get mobileDashboardFixedAssets;

  /// Mobile Dashboard user-facing text: Journal
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get mobileDashboardJournal;

  /// Mobile Dashboard user-facing text: Depreciation — Q4
  ///
  /// In en, this message translates to:
  /// **'Depreciation — Q4'**
  String get mobileDashboardDepreciationQ4;

  /// Mobile Dashboard user-facing text: 2h ago
  ///
  /// In en, this message translates to:
  /// **'2h ago'**
  String get mobileDashboardText2hAgo;

  /// Mobile Dashboard user-facing text: Office rent payment
  ///
  /// In en, this message translates to:
  /// **'Office rent payment'**
  String get mobileDashboardOfficeRentPayment;

  /// Mobile Dashboard user-facing text: 5h ago
  ///
  /// In en, this message translates to:
  /// **'5h ago'**
  String get mobileDashboardText5hAgo;

  /// Mobile Dashboard user-facing text: Revenue accrual
  ///
  /// In en, this message translates to:
  /// **'Revenue accrual'**
  String get mobileDashboardRevenueAccrual;

  /// Mobile Dashboard user-facing text: Utilities — Nov
  ///
  /// In en, this message translates to:
  /// **'Utilities — Nov'**
  String get mobileDashboardUtilitiesNov;

  /// Mobile Dashboard user-facing text: FX revaluation
  ///
  /// In en, this message translates to:
  /// **'FX revaluation'**
  String get mobileDashboardFxRevaluation;

  /// Mobile Dashboard user-facing text: Commercial
  ///
  /// In en, this message translates to:
  /// **'Commercial'**
  String get mobileDashboardCommercial;

  /// Mobile Dashboard user-facing text: Sales MTD
  ///
  /// In en, this message translates to:
  /// **'Sales MTD'**
  String get mobileDashboardSalesMtd;

  /// Mobile Dashboard user-facing text: Purchases MTD
  ///
  /// In en, this message translates to:
  /// **'Purchases MTD'**
  String get mobileDashboardPurchasesMtd;

  /// Mobile Dashboard user-facing text: Receivables
  ///
  /// In en, this message translates to:
  /// **'Receivables'**
  String get mobileDashboardReceivables;

  /// Mobile Dashboard user-facing text: Payables
  ///
  /// In en, this message translates to:
  /// **'Payables'**
  String get mobileDashboardPayables;

  /// Mobile Dashboard user-facing text: Sale
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get mobileDashboardSale;

  /// Mobile Dashboard user-facing text: Purchase
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get mobileDashboardPurchase;

  /// Mobile Dashboard user-facing text: Quotation
  ///
  /// In en, this message translates to:
  /// **'Quotation'**
  String get mobileDashboardQuotation;

  /// Mobile Dashboard user-facing text: Return
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get mobileDashboardReturnText;

  /// Mobile Dashboard user-facing text: 30m ago
  ///
  /// In en, this message translates to:
  /// **'30m ago'**
  String get mobileDashboardText30mAgo;

  /// Mobile Dashboard user-facing text: 3h ago
  ///
  /// In en, this message translates to:
  /// **'3h ago'**
  String get mobileDashboardText3hAgo;

  /// Mobile Dashboard user-facing text: TREASURY & CASH MANAGEMENT
  ///
  /// In en, this message translates to:
  /// **'TREASURY & CASH MANAGEMENT'**
  String get mobileDashboardTreasuryCashManagement;

  /// Mobile Dashboard user-facing text: Banking control center
  ///
  /// In en, this message translates to:
  /// **'Banking control center'**
  String get mobileDashboardBankingControlCenter;

  /// Mobile Dashboard user-facing text: Monitor liquidity, bank positions, transfers, and reconciliation activity across every legal entity.
  ///
  /// In en, this message translates to:
  /// **'Monitor liquidity, bank positions, transfers, and reconciliation activity across every legal entity.'**
  String
  get mobileDashboardMonitorLiquidityBankPositionsTransfersAndReconciliationActivityAcrossEveryLegalEntity;

  /// Mobile Dashboard user-facing text: New transfer
  ///
  /// In en, this message translates to:
  /// **'New transfer'**
  String get mobileDashboardNewTransfer;

  /// Mobile Dashboard user-facing text: Treasury status
  ///
  /// In en, this message translates to:
  /// **'Treasury status'**
  String get mobileDashboardTreasuryStatus;

  /// Mobile Dashboard user-facing text: Treasury workflow
  ///
  /// In en, this message translates to:
  /// **'Treasury workflow'**
  String get mobileDashboardTreasuryWorkflow;

  /// Mobile Dashboard user-facing text: Items that require action before the next cut-off.
  ///
  /// In en, this message translates to:
  /// **'Items that require action before the next cut-off.'**
  String get mobileDashboardItemsThatRequireActionBeforeTheNextCutOff;

  /// Mobile Dashboard user-facing text: Latest bank movements
  ///
  /// In en, this message translates to:
  /// **'Latest bank movements'**
  String get mobileDashboardLatestBankMovements;

  /// Mobile Dashboard user-facing text: Treasury exceptions
  ///
  /// In en, this message translates to:
  /// **'Treasury exceptions'**
  String get mobileDashboardTreasuryExceptions;

  /// Mobile Dashboard user-facing text: Connected accounts
  ///
  /// In en, this message translates to:
  /// **'Connected accounts'**
  String get mobileDashboardConnectedAccounts;

  /// Mobile Dashboard user-facing text: Across 3 banks
  ///
  /// In en, this message translates to:
  /// **'Across 3 banks'**
  String get mobileDashboardAcross3Banks;

  /// Mobile Dashboard user-facing text: Reconciliation
  ///
  /// In en, this message translates to:
  /// **'Reconciliation'**
  String get mobileDashboardReconciliation;

  /// Mobile Dashboard user-facing text: 3 statements pending
  ///
  /// In en, this message translates to:
  /// **'3 statements pending'**
  String get mobileDashboardText3StatementsPending;

  /// Mobile Dashboard user-facing text: Payment approvals
  ///
  /// In en, this message translates to:
  /// **'Payment approvals'**
  String get mobileDashboardPaymentApprovals;

  /// Mobile Dashboard user-facing text: SAR 284K awaiting release
  ///
  /// In en, this message translates to:
  /// **'SAR 284K awaiting release'**
  String get mobileDashboardSar284kAwaitingRelease;

  /// Mobile Dashboard user-facing text: Approve payment batch
  ///
  /// In en, this message translates to:
  /// **'Approve payment batch'**
  String get mobileDashboardApprovePaymentBatch;

  /// Mobile Dashboard user-facing text: Payroll and supplier wires
  ///
  /// In en, this message translates to:
  /// **'Payroll and supplier wires'**
  String get mobileDashboardPayrollAndSupplierWires;

  /// Mobile Dashboard user-facing text: 5 items
  ///
  /// In en, this message translates to:
  /// **'5 items'**
  String get mobileDashboardText5Items;

  /// Mobile Dashboard user-facing text: Reconcile bank statements
  ///
  /// In en, this message translates to:
  /// **'Reconcile bank statements'**
  String get mobileDashboardReconcileBankStatements;

  /// Mobile Dashboard user-facing text: Riyad Bank and SNB
  ///
  /// In en, this message translates to:
  /// **'Riyad Bank and SNB'**
  String get mobileDashboardRiyadBankAndSnb;

  /// Mobile Dashboard user-facing text: 3 open
  ///
  /// In en, this message translates to:
  /// **'3 open'**
  String get mobileDashboardText3Open;

  /// Mobile Dashboard user-facing text: Review 13-week cash forecast
  ///
  /// In en, this message translates to:
  /// **'Review 13-week cash forecast'**
  String get mobileDashboardReview13WeekCashForecast;

  /// Mobile Dashboard user-facing text: Updated with current commitments
  ///
  /// In en, this message translates to:
  /// **'Updated with current commitments'**
  String get mobileDashboardUpdatedWithCurrentCommitments;

  /// Mobile Dashboard user-facing text: Today
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get mobileDashboardToday;

  /// Mobile Dashboard user-facing text: Unreconciled statements
  ///
  /// In en, this message translates to:
  /// **'Unreconciled statements'**
  String get mobileDashboardUnreconciledStatements;

  /// Mobile Dashboard user-facing text: Bank statement lines remain unmatched
  ///
  /// In en, this message translates to:
  /// **'Bank statement lines remain unmatched'**
  String get mobileDashboardBankStatementLinesRemainUnmatched;

  /// Mobile Dashboard user-facing text: Payments awaiting approval
  ///
  /// In en, this message translates to:
  /// **'Payments awaiting approval'**
  String get mobileDashboardPaymentsAwaitingApproval;

  /// Mobile Dashboard user-facing text: Transfers are approaching the bank cut-off
  ///
  /// In en, this message translates to:
  /// **'Transfers are approaching the bank cut-off'**
  String get mobileDashboardTransfersAreApproachingTheBankCutOff;

  /// Mobile Dashboard user-facing text: Bank feed delayed
  ///
  /// In en, this message translates to:
  /// **'Bank feed delayed'**
  String get mobileDashboardBankFeedDelayed;

  /// Mobile Dashboard user-facing text: One account has not synchronized today
  ///
  /// In en, this message translates to:
  /// **'One account has not synchronized today'**
  String get mobileDashboardOneAccountHasNotSynchronizedToday;

  /// Mobile Dashboard user-facing text: GENERAL LEDGER & FINANCIAL CONTROL
  ///
  /// In en, this message translates to:
  /// **'GENERAL LEDGER & FINANCIAL CONTROL'**
  String get mobileDashboardGeneralLedgerFinancialControl;

  /// Mobile Dashboard user-facing text: Accounting command center
  ///
  /// In en, this message translates to:
  /// **'Accounting command center'**
  String get mobileDashboardAccountingCommandCenter;

  /// Mobile Dashboard user-facing text: Track close readiness, posting health, balances, and control exceptions from one operational workspace.
  ///
  /// In en, this message translates to:
  /// **'Track close readiness, posting health, balances, and control exceptions from one operational workspace.'**
  String
  get mobileDashboardTrackCloseReadinessPostingHealthBalancesAndControlExceptionsFromOneOperationalWorkspace;

  /// Mobile Dashboard user-facing text: Post journal
  ///
  /// In en, this message translates to:
  /// **'Post journal'**
  String get mobileDashboardPostJournal;

  /// Mobile Dashboard user-facing text: Close readiness
  ///
  /// In en, this message translates to:
  /// **'Close readiness'**
  String get mobileDashboardCloseReadiness;

  /// Mobile Dashboard user-facing text: Period-close workflow
  ///
  /// In en, this message translates to:
  /// **'Period-close workflow'**
  String get mobileDashboardPeriodCloseWorkflow;

  /// Mobile Dashboard user-facing text: Priority tasks for an accurate and controlled close.
  ///
  /// In en, this message translates to:
  /// **'Priority tasks for an accurate and controlled close.'**
  String get mobileDashboardPriorityTasksForAnAccurateAndControlledClose;

  /// Mobile Dashboard user-facing text: Recent postings
  ///
  /// In en, this message translates to:
  /// **'Recent postings'**
  String get mobileDashboardRecentPostings;

  /// Mobile Dashboard user-facing text: Accounting exceptions
  ///
  /// In en, this message translates to:
  /// **'Accounting exceptions'**
  String get mobileDashboardAccountingExceptions;

  /// Mobile Dashboard user-facing text: Open period
  ///
  /// In en, this message translates to:
  /// **'Open period'**
  String get mobileDashboardOpenPeriod;

  /// Mobile Dashboard user-facing text: DEC 2024
  ///
  /// In en, this message translates to:
  /// **'DEC 2024'**
  String get mobileDashboardDec2024;

  /// Mobile Dashboard user-facing text: Closes in 4 days
  ///
  /// In en, this message translates to:
  /// **'Closes in 4 days'**
  String get mobileDashboardClosesIn4Days;

  /// Mobile Dashboard user-facing text: Trial balance
  ///
  /// In en, this message translates to:
  /// **'Trial balance'**
  String get mobileDashboardTrialBalance;

  /// Mobile Dashboard user-facing text: Balanced
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get mobileDashboardBalanced;

  /// Mobile Dashboard user-facing text: No variance detected
  ///
  /// In en, this message translates to:
  /// **'No variance detected'**
  String get mobileDashboardNoVarianceDetected;

  /// Mobile Dashboard user-facing text: Unposted journals
  ///
  /// In en, this message translates to:
  /// **'Unposted journals'**
  String get mobileDashboardUnpostedJournals;

  /// Mobile Dashboard user-facing text: 2 require approval
  ///
  /// In en, this message translates to:
  /// **'2 require approval'**
  String get mobileDashboardText2RequireApproval;

  /// Mobile Dashboard user-facing text: Post recurring journals
  ///
  /// In en, this message translates to:
  /// **'Post recurring journals'**
  String get mobileDashboardPostRecurringJournals;

  /// Mobile Dashboard user-facing text: Rent, payroll, and depreciation
  ///
  /// In en, this message translates to:
  /// **'Rent, payroll, and depreciation'**
  String get mobileDashboardRentPayrollAndDepreciation;

  /// Mobile Dashboard user-facing text: 4 batches
  ///
  /// In en, this message translates to:
  /// **'4 batches'**
  String get mobileDashboardText4Batches;

  /// Mobile Dashboard user-facing text: Review control accounts
  ///
  /// In en, this message translates to:
  /// **'Review control accounts'**
  String get mobileDashboardReviewControlAccounts;

  /// Mobile Dashboard user-facing text: AR, AP, inventory, and tax
  ///
  /// In en, this message translates to:
  /// **'AR, AP, inventory, and tax'**
  String get mobileDashboardArApInventoryAndTax;

  /// Mobile Dashboard user-facing text: 2 variances
  ///
  /// In en, this message translates to:
  /// **'2 variances'**
  String get mobileDashboardText2Variances;

  /// Mobile Dashboard user-facing text: Lock operational subledgers
  ///
  /// In en, this message translates to:
  /// **'Lock operational subledgers'**
  String get mobileDashboardLockOperationalSubledgers;

  /// Mobile Dashboard user-facing text: After final posting review
  ///
  /// In en, this message translates to:
  /// **'After final posting review'**
  String get mobileDashboardAfterFinalPostingReview;

  /// Mobile Dashboard user-facing text: Pending
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get mobileDashboardPending;

  /// Mobile Dashboard user-facing text: Debits and credits do not match
  ///
  /// In en, this message translates to:
  /// **'Debits and credits do not match'**
  String get mobileDashboardDebitsAndCreditsDoNotMatch;

  /// Mobile Dashboard user-facing text: Draft and approval queues remain open
  ///
  /// In en, this message translates to:
  /// **'Draft and approval queues remain open'**
  String get mobileDashboardDraftAndApprovalQueuesRemainOpen;

  /// Mobile Dashboard user-facing text: Control account variances
  ///
  /// In en, this message translates to:
  /// **'Control account variances'**
  String get mobileDashboardControlAccountVariances;

  /// Mobile Dashboard user-facing text: AR and inventory require investigation
  ///
  /// In en, this message translates to:
  /// **'AR and inventory require investigation'**
  String get mobileDashboardArAndInventoryRequireInvestigation;

  /// Mobile Dashboard user-facing text: SALES, PURCHASING & ORDER FULFILMENT
  ///
  /// In en, this message translates to:
  /// **'SALES, PURCHASING & ORDER FULFILMENT'**
  String get mobileDashboardSalesPurchasingOrderFulfilment;

  /// Mobile Dashboard user-facing text: Commercial operations center
  ///
  /// In en, this message translates to:
  /// **'Commercial operations center'**
  String get mobileDashboardCommercialOperationsCenter;

  /// Mobile Dashboard user-facing text: Manage revenue execution, procurement commitments, receivables, and fulfilment risks across the business.
  ///
  /// In en, this message translates to:
  /// **'Manage revenue execution, procurement commitments, receivables, and fulfilment risks across the business.'**
  String
  get mobileDashboardManageRevenueExecutionProcurementCommitmentsReceivablesAndFulfilmentRisksAcrossTheBusiness;

  /// Mobile Dashboard user-facing text: Create sales order
  ///
  /// In en, this message translates to:
  /// **'Create sales order'**
  String get mobileDashboardCreateSalesOrder;

  /// Mobile Dashboard user-facing text: Commercial pulse
  ///
  /// In en, this message translates to:
  /// **'Commercial pulse'**
  String get mobileDashboardCommercialPulse;

  /// Mobile Dashboard user-facing text: Order-to-cash workflow
  ///
  /// In en, this message translates to:
  /// **'Order-to-cash workflow'**
  String get mobileDashboardOrderToCashWorkflow;

  /// Mobile Dashboard user-facing text: Operational work that can affect revenue and customer service.
  ///
  /// In en, this message translates to:
  /// **'Operational work that can affect revenue and customer service.'**
  String
  get mobileDashboardOperationalWorkThatCanAffectRevenueAndCustomerService;

  /// Mobile Dashboard user-facing text: Latest commercial documents
  ///
  /// In en, this message translates to:
  /// **'Latest commercial documents'**
  String get mobileDashboardLatestCommercialDocuments;

  /// Mobile Dashboard user-facing text: Commercial exceptions
  ///
  /// In en, this message translates to:
  /// **'Commercial exceptions'**
  String get mobileDashboardCommercialExceptions;

  /// Mobile Dashboard user-facing text: Open sales orders
  ///
  /// In en, this message translates to:
  /// **'Open sales orders'**
  String get mobileDashboardOpenSalesOrders;

  /// Mobile Dashboard user-facing text: SAR 1.14M pipeline
  ///
  /// In en, this message translates to:
  /// **'SAR 1.14M pipeline'**
  String get mobileDashboardSar114mPipeline;

  /// Mobile Dashboard user-facing text: On-time fulfilment
  ///
  /// In en, this message translates to:
  /// **'On-time fulfilment'**
  String get mobileDashboardOnTimeFulfilment;

  /// Mobile Dashboard user-facing text: 4 orders at risk
  ///
  /// In en, this message translates to:
  /// **'4 orders at risk'**
  String get mobileDashboardText4OrdersAtRisk;

  /// Mobile Dashboard user-facing text: Overdue receivables
  ///
  /// In en, this message translates to:
  /// **'Overdue receivables'**
  String get mobileDashboardOverdueReceivables;

  /// Mobile Dashboard user-facing text: SAR 176K overdue
  ///
  /// In en, this message translates to:
  /// **'SAR 176K overdue'**
  String get mobileDashboardSar176kOverdue;

  /// Mobile Dashboard user-facing text: Release blocked sales orders
  ///
  /// In en, this message translates to:
  /// **'Release blocked sales orders'**
  String get mobileDashboardReleaseBlockedSalesOrders;

  /// Mobile Dashboard user-facing text: Credit and margin checks
  ///
  /// In en, this message translates to:
  /// **'Credit and margin checks'**
  String get mobileDashboardCreditAndMarginChecks;

  /// Mobile Dashboard user-facing text: 4 orders
  ///
  /// In en, this message translates to:
  /// **'4 orders'**
  String get mobileDashboardText4Orders;

  /// Mobile Dashboard user-facing text: Confirm purchase commitments
  ///
  /// In en, this message translates to:
  /// **'Confirm purchase commitments'**
  String get mobileDashboardConfirmPurchaseCommitments;

  /// Mobile Dashboard user-facing text: Lead-time changes from suppliers
  ///
  /// In en, this message translates to:
  /// **'Lead-time changes from suppliers'**
  String get mobileDashboardLeadTimeChangesFromSuppliers;

  /// Mobile Dashboard user-facing text: 6 lines
  ///
  /// In en, this message translates to:
  /// **'6 lines'**
  String get mobileDashboardText6Lines;

  /// Mobile Dashboard user-facing text: Follow up overdue invoices
  ///
  /// In en, this message translates to:
  /// **'Follow up overdue invoices'**
  String get mobileDashboardFollowUpOverdueInvoices;

  /// Mobile Dashboard user-facing text: Top customer balances
  ///
  /// In en, this message translates to:
  /// **'Top customer balances'**
  String get mobileDashboardTopCustomerBalances;

  /// Mobile Dashboard user-facing text: 8 accounts
  ///
  /// In en, this message translates to:
  /// **'8 accounts'**
  String get mobileDashboardText8Accounts;

  /// Mobile Dashboard user-facing text: Orders on credit hold
  ///
  /// In en, this message translates to:
  /// **'Orders on credit hold'**
  String get mobileDashboardOrdersOnCreditHold;

  /// Mobile Dashboard user-facing text: Customer limits or overdue balances exceeded
  ///
  /// In en, this message translates to:
  /// **'Customer limits or overdue balances exceeded'**
  String get mobileDashboardCustomerLimitsOrOverdueBalancesExceeded;

  /// Mobile Dashboard user-facing text: Fulfilment shortages
  ///
  /// In en, this message translates to:
  /// **'Fulfilment shortages'**
  String get mobileDashboardFulfilmentShortages;

  /// Mobile Dashboard user-facing text: Committed quantities exceed available stock
  ///
  /// In en, this message translates to:
  /// **'Committed quantities exceed available stock'**
  String get mobileDashboardCommittedQuantitiesExceedAvailableStock;

  /// Mobile Dashboard user-facing text: Supplier delivery changes
  ///
  /// In en, this message translates to:
  /// **'Supplier delivery changes'**
  String get mobileDashboardSupplierDeliveryChanges;

  /// Mobile Dashboard user-facing text: Expected dates were updated by vendors
  ///
  /// In en, this message translates to:
  /// **'Expected dates were updated by vendors'**
  String get mobileDashboardExpectedDatesWereUpdatedByVendors;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Accounting Dashboard'**
  String get accountingDashboard;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get addCustomer;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Add Supplier'**
  String get addSupplier;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Administration'**
  String get administration;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Banking Dashboard'**
  String get bankingDashboard;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Banking · Cash'**
  String get bankingCash;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Banking · Transfers'**
  String get bankingTransfers;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Commercial Dashboard'**
  String get commercialDashboard;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'External Wire Details'**
  String get externalWireDetails;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Inventory Dashboard'**
  String get inventoryDashboard;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Issue — Details'**
  String get issueDetailsMore;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Journal Entry Details'**
  String get journalEntryDetails;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Local Transfer Details'**
  String get localTransferDetails;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Opening Journal Entry'**
  String get openingJournalEntry;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Procurement · Suppliers'**
  String get procurementSuppliers;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Products List'**
  String get productsList;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Receive — Details'**
  String get receiveDetailsMore;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Roles & Permissions'**
  String get rolesPermissions;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Sales · Customers'**
  String get salesCustomers;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Transfer — Details'**
  String get transferDetailsMore;

  /// Navigation label used in the More screen.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// Mobile Dashboard user-facing text: Debits and credits don''t match
  ///
  /// In en, this message translates to:
  /// **'Debits and credits don\'\'t match'**
  String get mobileDashboardDebitsAndCreditsDonTMatch2;

  /// Mobile Dashboard user-facing text: 9a
  ///
  /// In en, this message translates to:
  /// **'9a'**
  String get mobileDashboardText9a;

  /// Mobile Dashboard user-facing text: 12p
  ///
  /// In en, this message translates to:
  /// **'12p'**
  String get mobileDashboardText12p;

  /// Mobile Dashboard user-facing text: 3p
  ///
  /// In en, this message translates to:
  /// **'3p'**
  String get mobileDashboardText3p;

  /// Mobile Dashboard user-facing text: 6p
  ///
  /// In en, this message translates to:
  /// **'6p'**
  String get mobileDashboardText6p;

  /// Mobile Dashboard user-facing text: now
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get mobileDashboardNow;

  /// Mobile Dashboard user-facing text: M
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get mobileDashboardM;

  /// Mobile Dashboard user-facing text: T
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get mobileDashboardT;

  /// Mobile Dashboard user-facing text: W
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get mobileDashboardW;

  /// Mobile Dashboard user-facing text: F
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get mobileDashboardF;

  /// Mobile Dashboard user-facing text: S
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get mobileDashboardS;

  /// Mobile Dashboard user-facing text: W1
  ///
  /// In en, this message translates to:
  /// **'W1'**
  String get mobileDashboardW1;

  /// Mobile Dashboard user-facing text: W2
  ///
  /// In en, this message translates to:
  /// **'W2'**
  String get mobileDashboardW2;

  /// Mobile Dashboard user-facing text: W3
  ///
  /// In en, this message translates to:
  /// **'W3'**
  String get mobileDashboardW3;

  /// Mobile Dashboard user-facing text: W4
  ///
  /// In en, this message translates to:
  /// **'W4'**
  String get mobileDashboardW4;

  /// Mobile Dashboard user-facing text: W5
  ///
  /// In en, this message translates to:
  /// **'W5'**
  String get mobileDashboardW5;

  /// Mobile Dashboard user-facing text: W6
  ///
  /// In en, this message translates to:
  /// **'W6'**
  String get mobileDashboardW6;

  /// Mobile Dashboard user-facing text: W7
  ///
  /// In en, this message translates to:
  /// **'W7'**
  String get mobileDashboardW7;

  /// Mobile Dashboard user-facing text: W8
  ///
  /// In en, this message translates to:
  /// **'W8'**
  String get mobileDashboardW8;

  /// Mobile Dashboard user-facing text: Al-Rashid Trading Co.
  ///
  /// In en, this message translates to:
  /// **'Al-Rashid Trading Co.'**
  String get mobileDashboardAlRashidTradingCo;

  /// Mobile Dashboard user-facing text: Najd Holdings
  ///
  /// In en, this message translates to:
  /// **'Najd Holdings'**
  String get mobileDashboardNajdHoldings;

  /// Mobile Dashboard user-facing text: Coastal Logistics
  ///
  /// In en, this message translates to:
  /// **'Coastal Logistics'**
  String get mobileDashboardCoastalLogistics;

  /// Mobile Dashboard user-facing text: Gulf Contracting Ltd
  ///
  /// In en, this message translates to:
  /// **'Gulf Contracting Ltd'**
  String get mobileDashboardGulfContractingLtd;

  /// Mobile Dashboard user-facing text: Saudi Steel Co
  ///
  /// In en, this message translates to:
  /// **'Saudi Steel Co'**
  String get mobileDashboardSaudiSteelCo;

  /// Mobile Dashboard user-facing text: Najd Builders
  ///
  /// In en, this message translates to:
  /// **'Najd Builders'**
  String get mobileDashboardNajdBuilders;

  /// Mobile Dashboard user-facing text: Coastal Cement
  ///
  /// In en, this message translates to:
  /// **'Coastal Cement'**
  String get mobileDashboardCoastalCement;

  /// Mobile Dashboard user-facing text: Eastern Timber
  ///
  /// In en, this message translates to:
  /// **'Eastern Timber'**
  String get mobileDashboardEasternTimber;
}

class _GeniusLinkLocalizationDelegate
    extends LocalizationsDelegate<GeniusLinkLocalization> {
  const _GeniusLinkLocalizationDelegate();

  @override
  Future<GeniusLinkLocalization> load(Locale locale) {
    return SynchronousFuture<GeniusLinkLocalization>(
      lookupGeniusLinkLocalization(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_GeniusLinkLocalizationDelegate old) => false;
}

GeniusLinkLocalization lookupGeniusLinkLocalization(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return GeniusLinkLocalizationAr();
    case 'en':
      return GeniusLinkLocalizationEn();
  }

  throw FlutterError(
    'GeniusLinkLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
