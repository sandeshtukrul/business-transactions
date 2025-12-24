// App Branding
const String appName = 'LedgerFlow';
const String appTagline = 'Business Made Simple';

// --- APP TITLES & NAVIGATION ---
const String homeTitlePrefix = 'Welcome';
const String balanceAmount = 'Balance Amount';
const String addCustomerAppbarTitle = 'Add New Customer';
const String addTransactionAppbarTitle = 'Add New Transaction';
const String updateTransactionAppbarTitle = 'Update Transaction';
const String customerDetailsTitle = customerDetailsHeader;
const String errorTitle = 'Error';
const String loadingText = 'Loading...';

// Tabs
const String customers = 'Customers';
const String vendors = 'Vendors';
const String history = 'History';

// --- LABELS & HEADERS ---
// Form & General Labels
const String customerNameLabel = 'Customer Name';
const String partyNameLabel = 'Party Name (Paid / Received)';
const String transactionTypeLabel = 'Transaction Type';
const String paymentMethodLabel = 'Payment Method';
const String descriptionLabel = 'Description (Optional)';
const String amountLabel = 'Amount';
const String selectMethodHint = 'Select Method';

// Section Headers
const String transactionDetailsLabel = 'Transaction Details';
const String customerDetailsHeader = 'Customer Details';

// Radio Button Labels
const String send = 'Send';
const String receive = 'Receive';

// --- BUTTON TEXTS ---
const String sendAndReceive = 'Send & Receive';
const String deleteCustomerButton = 'Delete Customer';
const String deleteTransactionButton = 'Delete Transaction';
const String deleteButton = 'Delete';
const String saveButton = 'Save';
const String cancelButton = 'Cancel';
const String completeAndSaveButton = 'COMPLETE & SAVE';
const String undoButton = 'UNDO';
const String retryButton = 'Retry';
const String dismissButton = 'Dismiss';
const String setButton = 'Set';
const String editButton = 'Edit';

// --- DIALOGS ---
// Titles
const String editCustomerNameTitle = 'Edit Customer Name';
const String deleteCustomerTitle = deleteCustomerButton;
const String deleteTransactionTitle = deleteTransactionButton;

// Content
const String deleteConfirmContent = 'Are you sure you want to delete';

// --- VALIDATION MESSAGES ---
const String enterNameError = 'Please enter a';
const String enterAmountError = 'Please enter an amount';
const String validAmountError = 'Please enter a valid number';
const String selectPaymentMethodError = 'Please select a payment method';

// --- ERROR MESSAGES & STATES ---
// For ErrorState Widget
const String errorStateDefaultTitle = 'Oops! Something went wrong.';
const String errorStateDefaultSubtitle =
    "We couldn't load your data. Please try again.";
const String errorStateShowDetails = 'Show Technical Details';

// --- SNACKBAR & TOAST MESSAGES ---
const String updatedSuccessfully = 'updated successfully';
const String deletedSuccessfully = 'deleted successfully';
const String addedSuccessfully = 'added successfully';
const String newTransactionAdded = 'New Transaction added to';
const String formSaveError = 'error occured while saving';

// --- INFORMATIONAL & EMPTY STATE MESSAGES ---
const String splashInitializationFailedTitle = 'Initialization Failed';
const String addFirstCustomerHint = 'Tap the + button to add first customer.';
const String noCustomersTitle = 'Looking for Customers?';
const String noDescription = 'No description';
const String noTransactionsTitle = 'Looking for Transactions?';
const String noTransactionsFoundHint =
    "Tap the + button to add first transaction.";

// --- DATA & STORAGE ---
// Hive Box Names
const String customersBox = 'customers';

// Default Data
const List<String> paymentMethods = ['Cash', 'Bank Transfer', 'UPI'];

// --- ASSET PATHS ---
const String appbarWavesSvgPath = 'assets/vectors/appbar_waves.svg';
const String noCustomersLottiePath = 'assets/lottie/no_customers.json';
const String noTransactionsLottiePath = 'assets/lottie/no_transactions.json';

// --- EXCEPTION MESSAGES ---
const String couldNotFetchCustomersException = 'Could not fetch customers';
const String couldNotSaveCustomerException = 'Could not save customer';
const String couldNotDeleteCustomerException = 'Could not delete customer id';
const String dataSourceNotInitializedException =
    'CustomerLocalDataSource not initialized! Call init() first.';
const String couldNotFetchCustomerByIdException =
    'Could not fetch customer by ID';
const String customerNotFoundException = 'Customer not found';

// --- FORMATTING & LOCALIZATION ---
// Date & Time Formats
const String dateFormatMMMddyyyy = 'MMM dd, yyyy';
const String timeFormathhmma = 'hh:mm a';
const String dateTimeFormatdMMMyhmma = 'd MMM y, h:mm a';

// Currency & Locale Codes
const String localeENIN = 'en_IN';
const String inrCurrencyCode = 'INR';

// --- UI DEFAULTS & PLACEHOLDERS ---

// HomeScreen Defaults
const String guestUsername = 'Guest';
const String zeroBalance = '0';

// --- SYMBOLS & PUNCTUATION ---
const String plusSign = '+';
const String minusSign = '-';
const String questionMark = '?';
const String colon = ':';

// --- MISCELLANEOUS ---
const String proximaNovaFont = 'ProximaNova';
const String monospaceFont = 'monospace';
const String stackTraceLabel = 'StackTrace:';
