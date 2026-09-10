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
