import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../data/requests_service.dart';
import '../../data/models/request_models.dart';
import 'requests_list_screen.dart'; // for provider refresh if needed

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  return ref.read(requestsServiceProvider).getCategories();
});

final servicesProvider = FutureProvider<List<Service>>((ref) async {
  return ref.read(requestsServiceProvider).getServices();
});

class CreateRequestScreen extends ConsumerStatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  ConsumerState<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends ConsumerState<CreateRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _detailsController = TextEditingController();
  final _cityController = TextEditingController();
  final _dateController = TextEditingController();
  
  Category? _selectedCategory;
  Service? _selectedService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null || _selectedService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select category and service')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(requestsServiceProvider).createRequest(
        categoryId: _selectedCategory!.id,
        serviceId: _selectedService!.id,
        details: _detailsController.text,
        city: _cityController.text,
        scheduledDate: _dateController.text,
      );
      
      // Refresh list
      ref.invalidate(myRequestsProvider);
      
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request created successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final servicesAsync = ref.watch(servicesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('New Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Dropdown
                categoriesAsync.when(
                  data: (categories) => DropdownButtonFormField<Category>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: categories.map<DropdownMenuItem<Category>>((c) => DropdownMenuItem<Category>(
                      value: c,
                      child: Text(c.name),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                        _selectedService = null; // Reset service
                      });
                    },
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text('Error loading categories: $e'),
                ),
                const SizedBox(height: 16),
                
                // Service Dropdown (Filtered by Category)
                servicesAsync.when(
                  data: (services) {
                    final filteredServices = _selectedCategory == null 
                        ? [] 
                        : services.where((s) => s.categoryId == _selectedCategory!.id).toList();
                    
                    return DropdownButtonFormField<Service>(
                      value: _selectedService,
                      decoration: const InputDecoration(labelText: 'Service'),
                      items: filteredServices.map<DropdownMenuItem<Service>>((s) => DropdownMenuItem<Service>(
                        value: s,
                        child: Text(s.name),
                      )).toList(),
                      onChanged: _selectedCategory == null ? null : (value) {
                        setState(() => _selectedService = value);
                      },
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text('Error loading services: $e'),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (v) => v?.isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Scheduled Date (YYYY-MM-DD)',
                    hintText: '2024-12-31',
                  ),
                  validator: (v) => v?.isEmpty == true ? 'Required' : null,
                  onTap: () async {
                    // Optional: Add DatePicker
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _detailsController,
                  decoration: const InputDecoration(labelText: 'Details'),
                  maxLines: 3,
                  validator: (v) => v?.isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Submit Request'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
