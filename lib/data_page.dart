import 'package:flutter/material.dart';
import 'api/api_service.dart';
import 'db_connection.dart';

class DataPage extends StatefulWidget {
  final String token;
  final String userId;
  final String userName;

  const DataPage({
    super.key,
    required this.token,
    required this.userId,
    required this.userName,
  });

  @override
  DataPageState createState() => DataPageState();
}

class DataPageState extends State<DataPage> {
  List<dynamic> _data = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final timestamp = DateTime.now();
    final id = DBConnection.generateUniqueId(
      username: widget.userName,
      formName: 'DataPage',
    );

    try {
      final response = await ApiService.fetchData(widget.token);
      if (!response.hasError) {
        setState(() {
          _data = response.data!;
          _isLoading = false;
        });

        // Rekam log berhasil mengambil data
        final conn = await DBConnection.getConnection();
        await DBConnection.recordUserLogTrail(
          conn,
          userId: id,
          userName: widget.userName,
          logDetails: 'Data fetched successfully',
          formName: 'DataPage',
          logType: 'INFO',
          description: 'User fetched data from the server',
          source: 'ClientApp',
          computerName: 'UserDevice', // Atau gunakan nama perangkat yang dinamis jika ada
          timestamp: timestamp,
        );
        await conn.close();
      } else {
        setState(() {
          _errorMessage = response.errorMessage!;
          _isLoading = false;
        });

        // Rekam log jika gagal mengambil data
        final conn = await DBConnection.getConnection();
        await DBConnection.recordUserLogTrail(
          conn,
          userId: id,
          userName: widget.userName,
          logDetails: 'Failed to fetch data',
          formName: 'DataPage',
          logType: 'ERROR',
          description: 'Failed to fetch data from the server',
          source: 'ClientApp',
          computerName: 'UserDevice',
          timestamp: timestamp,
        );
        await conn.close();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan: $e';
        _isLoading = false;
      });

      // Rekam log jika terjadi kesalahan
      final conn = await DBConnection.getConnection();
      await DBConnection.recordUserLogTrail(
        conn,
        userId: id,
        userName: widget.userName,
        logDetails: 'Exception: $e',
        formName: 'DataPage',
        logType: 'ERROR',
        description: 'An exception occurred while fetching data',
        source: 'ClientApp',
        computerName: 'UserDevice',
        timestamp: timestamp,
      );
      await conn.close();
    }
  }

  void _showUserSnackBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User: ${widget.userName} (ID: ${widget.userId})'),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _showUserSnackBar();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data from MySQL'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_data[index]['username']),
                      subtitle: Text('UserID: ${_data[index]['UserID']}'),
                    );
                  },
                ),
    );
  }
}
