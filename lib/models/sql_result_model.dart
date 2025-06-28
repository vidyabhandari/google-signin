import 'dart:convert';

class SQLResultmodel {
  final int errorNo;
  final int id;
  final String? errorMessage;
  final String? documentNo;
  final int sqlErrorNumber;
  final int sqlErrorSeverity;
  final int sqlErrorState;
  final String? sqlObjectName;
  final int sqlErrorLineNo;
  final String? sqlErrorMessage;

  SQLResultmodel({
    required this.id,
    required this.errorNo,
    this.documentNo,
    required this.sqlErrorNumber,
    required this.sqlErrorSeverity,
    required this.sqlErrorState,
    this.errorMessage,
    this.sqlObjectName,
    required this.sqlErrorLineNo,
    this.sqlErrorMessage,
  });

  factory SQLResultmodel.fromJson(Map<String, dynamic> json) {
    return SQLResultmodel(
      errorNo: json['errorNo'] ?? 0,
      id: json['id'] ?? 0,
      errorMessage: json['errorMessage'],
      documentNo: json['documentNo']?.toString(),
      sqlErrorNumber: json['sqlErrorNumber'] ?? 0,
      sqlErrorSeverity: json['sqlErrorServity'] ?? 0,
      sqlErrorState: json['sqlErrorState'] ?? 0,
      sqlObjectName: json['sqlObjectName'],
      sqlErrorLineNo: json['sqlErrorLine'] ?? 0,
      sqlErrorMessage: json['sqlMessage'],
    );
  }
}

// public class SQLResult
// {
//     [Key]
//     [Display(Name = "ID")]
//     public long ID { get; set; }

//     [Display(Name = "Error No.")]
//     public long ErrorNo { get; set; }

//     [Display(Name = "Error Message")]
//     public string? ErrorMessage { get; set; }

//     [Display(Name = "Document No.")]
//     public string? DocumentNo { get; set; }

//     [Display(Name = "SQL Error No.")]
//     public int sqlErrorNumber { get; set; }

//     [Display(Name = "SQL Severity")]
//     public int sqlErrorSeverity { get; set; }

//     [Display(Name = "SQL State")]
//     public int sqlErrorState { get; set; }

//     [Display(Name = "SQL Object Name")]
//     public string? sqlObjectName { get; set; }

//     [Display(Name = "Line No.")]
//     public int sqlErrorLineNo { get; set; }

//     [Display(Name = "SQL Error Message")]
//     public string? sqlErrorMessage { get; set; }
// }
