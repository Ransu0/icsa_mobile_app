import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for Clipboard

class FinesDashboardScreen extends StatefulWidget {
  const FinesDashboardScreen({super.key});

  @override
  State<FinesDashboardScreen> createState() => _FinesDashboardState();
}

class _FinesDashboardState extends State<FinesDashboardScreen> {
  // Example data: pending fines
  List<Map<String, dynamic>> pending = [
    {
      'title': 'Panagtagbo 2025',
      'date': 'August 29, 2025',
      'due': 'September 2, 2025',
      'amount': 100.00,
      'details': [
        {'label': 'Missing Time In/Time Out', 'amount': 100.00},
        {'label': 'Failure to attend the Time in', 'amount': 50.00},
        {'label': 'Failure to attend the Time out', 'amount': 50.00},
      ],
    },
    {
      'title': 'IC Day 2025',
      'date': 'July 15, 2025',
      'due': 'July 30, 2025',
      'amount': 50.00,
      'details': [
        {'label': 'Late Arrival', 'amount': 50.00},
      ],
    },
    {
      'title': 'Library Fine',
      'date': 'June 02, 2025',
      'due': 'June 12, 2025',
      'amount': 25.00,
      'details': [
        {'label': 'Overdue Book', 'amount': 25.00},
      ],
    },
  ];

  // Example data: recent payments
  List<Map<String, dynamic>> recent = [
    {
      'title': 'Student Council Donation',
      'datePaid': 'May 10, 2025',
      'amount': 150.00,
      'method': 'Gcash',
      'details': [
        {'label': 'Donation for Event A', 'amount': 100.00},
        {'label': 'Donation for Event B', 'amount': 50.00},
      ],
    },
    {
      'title': 'Library Fine (paid)',
      'datePaid': 'April 22, 2025',
      'amount': 25.00,
      'method': 'Over the Counter',
      'details': [
        {'label': 'Overdue Book', 'amount': 25.00},
      ],
    },
  ];

  String searchQuery = '';
  int tabIndex = 0; // 0: Pending, 1: Recent
  int?
      expandedIndex; // index of the currently expanded Pending item (null if none)
  int? expandedRecentIndex;

  // In recent tab we won't have expansion behavior (history only)

  // Using the uploaded image path for the back/left icon or header illustration as requested:
  final String uploadedImagePath =
      '/mnt/data/image.png'; // developer-provided path

  List<Map<String, dynamic>> get filteredPending {
    if (searchQuery.trim().isEmpty) return pending;
    final q = searchQuery.toLowerCase();
    return pending.where((p) {
      final title = (p['title'] as String).toLowerCase();
      return title.contains(q);
    }).toList();
  }

  List<Map<String, dynamic>> get filteredRecent {
    if (searchQuery.trim().isEmpty) return recent;
    final q = searchQuery.toLowerCase();
    return recent.where((r) {
      final title = (r['title'] as String).toLowerCase();
      return title.contains(q);
    }).toList();
  }

  void _openMakePaymentSheet(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: _PaymentOptionsSheet(item: item),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF232833),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
          child: Column(
            children: [
              // Top row: back + title (and a small image icon using uploaded path)
              Row(
                children: [
                  // Back circle button
                  InkWell(
                    onTap: () => Navigator.maybePop(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F3740),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Payments and Fines',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  // small placeholder image from uploaded path (optional)
                  // (If this path doesn't exist on device, it will show blank)
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        uploadedImagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const SizedBox.shrink(), // ignore missing image
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Search bar row (no icon to the side as requested)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E353D),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.white54),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              onChanged: (v) {
                                setState(() {
                                  searchQuery = v;
                                  // close expanded detail when searching
                                  expandedIndex = null;
                                });
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: Colors.white38, fontSize: 16),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Tabs: Pending Fines / Recent Payments
              Row(
                children: [
                  // Pending button
                  GestureDetector(
                    onTap: () {
                      setState(() => tabIndex = 0);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: tabIndex == 0
                            ? const Color(0xFFFF8A1F)
                            : const Color(0xFF2E353D),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: tabIndex == 0
                            ? [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2))
                              ]
                            : [],
                      ),
                      child: Text(
                        'Pending Fines',
                        style: TextStyle(
                          color: tabIndex == 0 ? Colors.white : Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Recent button
                  GestureDetector(
                    onTap: () {
                      setState(() => tabIndex = 1);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: tabIndex == 1
                            ? const Color(0xFF2E353D)
                            : const Color(0xFF2E353D),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Text(
                        'Recent Payments',
                        style: TextStyle(
                          color: tabIndex == 1 ? Colors.white : Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Content area — scrollable
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tabIndex == 0) ...[
                          const Text(
                            'Unpaid',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Render filtered pending list as cards plus details below the card
                          ...List.generate(filteredPending.length, (i) {
                            final item = filteredPending[i];
                            // original index in pending (needed if you want to reference original list)
                            final originalIndex = pending.indexOf(item);
                            final isExpanded = expandedIndex == originalIndex;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // The card
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2C3440),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['title'],
                                              style: const TextStyle(
                                                  color: Color(0xFFFF8A1F),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '₱${(item['amount'] as double).toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // More / Less button
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (isExpanded) {
                                              expandedIndex = null;
                                            } else {
                                              expandedIndex = originalIndex;
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              isExpanded ? 'Less' : 'View',
                                              style: const TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(
                                              isExpanded
                                                  ? Icons.arrow_back_ios_new
                                                  : Icons.arrow_forward_ios,
                                              size: 16,
                                              color: Colors.white70,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // The details box appears below the card (outside the card)
                                if (isExpanded)
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2E353D),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Details',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        // rows
                                        _detailRow('Date', item['date']),
                                        const SizedBox(height: 6),
                                        _detailRow('Due date', item['due']),
                                        const SizedBox(height: 6),
                                        _detailRow('Amount',
                                            '₱${(item['amount'] as double).toStringAsFixed(2)}'),
                                        const SizedBox(height: 12),
                                        // break down detail lines
                                        ...List<Widget>.from(
                                          (item['details'] as List).map((d) =>
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        d['label'],
                                                        style: const TextStyle(
                                                          color: Colors.white70,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '₱${(d['amount'] as double).toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  _openMakePaymentSheet(item),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFFFF8A1F),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 12),
                                              ),
                                              child: const Text(
                                                'Make Payment',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ] else ...[
                          // Recent Payments tab
                          const Text(
                            'Recent Payments',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(filteredRecent.length, (i) {
                            final r = filteredRecent[i];
                            final isExpanded = expandedRecentIndex == i;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // The card
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2C3440),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            r['title'],
                                            style: const TextStyle(
                                                color: Color(0xFFFF8A1F),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            r['datePaid'],
                                            style: const TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            expandedRecentIndex =
                                                isExpanded ? null : i;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              isExpanded ? 'Less' : 'View',
                                              style: const TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(
                                              isExpanded
                                                  ? Icons.arrow_back_ios_new
                                                  : Icons.arrow_forward_ios,
                                              size: 16,
                                              color: Colors.white70,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Expanded details
                                if (isExpanded)
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2E353D),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _detailRow('Amount',
                                            '₱${(r['amount'] as double).toStringAsFixed(2)}'),
                                        const SizedBox(height: 6),
                                        _detailRow(
                                            'Payment Method', r['method']),
                                        const SizedBox(height: 12),
                                        ...List<Widget>.from(
                                          (r['details'] as List).map(
                                            (d) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(d['label'],
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white70)),
                                                  ),
                                                  Text(
                                                      '₱${(d['amount'] as double).toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(width: 12),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

class _PaymentOptionsSheet extends StatefulWidget {
  final Map<String, dynamic> item;
  const _PaymentOptionsSheet({required this.item});

  @override
  State<_PaymentOptionsSheet> createState() => _PaymentOptionsSheetState();
}

class _PaymentOptionsSheetState extends State<_PaymentOptionsSheet> {
  String selected = 'ewallet'; // 'ewallet' or 'otc'

  // Example collector details for Over the Counter
  final collector = {
    'name': 'IC LSG Office',
    'contact': '+63 912 345 6789',
    'email': 'collector@example.com',
    'social': 'm.me/ICCollector', // messenger link placeholder
  };

  // Example GCash details
  final gcashName = 'IC LSG Collection';
  final gcashNumber = '0917 123 4567';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sheet drag handle
            Center(
              child: Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Make Payment - ${widget.item['title']}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Option selector
            Row(
              children: [
                ChoiceChip(
                  label: const Text('E-wallet'),
                  selected: selected == 'ewallet',
                  onSelected: (v) {
                    setState(() => selected = 'ewallet');
                  },
                  selectedColor: const Color(0xFFFF8A1F),
                  backgroundColor: const Color(0xFF2E353D),
                  labelStyle: TextStyle(
                      color: selected == 'ewallet'
                          ? Colors.white
                          : Colors.white70),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('Over the Counter'),
                  selected: selected == 'otc',
                  onSelected: (v) {
                    setState(() => selected = 'otc');
                  },
                  selectedColor: const Color(0xFFFF8A1F),
                  backgroundColor: const Color(0xFF2E353D),
                  labelStyle: TextStyle(
                      color: selected == 'otc' ? Colors.white : Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: selected == 'ewallet' ? _ewalletView() : _otcView(),
              ),
            ),
            const SizedBox(height: 8),
            // Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close',
                      style: TextStyle(color: Colors.white70)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _ewalletView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'E-wallet (Gcash)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2C3440),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account Name: $gcashName',
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: Text('Number: $gcashNumber',
                          style: const TextStyle(color: Colors.white))),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: gcashNumber));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('GCash number copied')));
                    },
                    icon: const Icon(Icons.copy, color: Colors.white70),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Instructions:\n1. Open GCash and send the total amount to the number above.\n2. Take a screenshot of your transaction.\n3. Message the collector with the screenshot and your student ID.',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _otcView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Over the Counter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2C3440),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            children: [
              // round logo placeholder
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF3A424B),
                child: const Text('IC', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              Text('${collector['name']}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Divider(color: Colors.white12),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Name: ', style: TextStyle(color: Colors.white70)),
                  Text('Ms. Juan Dela Cruz',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Message me at: ',
                      style: TextStyle(color: Colors.white70)),
                  Text('${collector['contact']}',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Email: ',
                      style: TextStyle(color: Colors.white70)),
                  Text('${collector['email']}',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Socials: ',
                      style: TextStyle(color: Colors.white70)),
                  Text('Messenger: ${collector['social']}',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Bring a printed or digital copy of proof of payment to the IC LSG Office to complete your payment.',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
