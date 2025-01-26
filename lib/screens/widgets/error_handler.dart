import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/models/error_rm.dart';
import 'package:go_router/go_router.dart';

class ErrorInterceptor extends Interceptor {
  final BuildContext context;

  ErrorInterceptor(this.context);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      _showUnauthorizedDialog();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response?.data is Map<String, dynamic>) {
      try {
        // Parse the error response
        final errorResponse = ErrorRM.fromJson(err.response?.data);
        _showErrorDialog(errorResponse.detail);
        // Create a new DioError with the parsed error
        final updatedError = DioError(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: errorResponse, // Attach the custom error
        );
        handler.next(updatedError); // Pass the updated error

        return;
      } catch (e) {
        // Handle cases where parsing fails
        final fallbackError = DioError(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: ErrorRM(
            detail: "Error parsing server response",
          ),
        );
        handler.next(fallbackError);
        return;
      }
    }

    super.onError(err, handler); // For non-JSON errors, pass the original error
  }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   final decoded = jsonDecode(err.response?.data) as Map<String, dynamic>;
  //   if (err.response?.statusCode == 401) {
  //     _showUnauthorizedDialog();
  //   } else {
  //     _showErrorDialog(decoded['detail'] ?? 'An unknown error occurred.');
  //   }
  //   super.onError(err, handler);
  // }

  void _showUnauthorizedDialog() {
    if (context.mounted) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Unauthorized'),
            content:
                const Text('You are not authorized to perform this action.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  GoRouter.of(context).pushReplacement("/login");
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _showErrorDialog(String? detail) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(detail ?? 'An error occurred.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {}
  }
}
