Attribute VB_Name = "Module1"
'-------------------------------------------------------------------------------------------------------
' RUN ALL test test test
'-------------------------------------------------------------------------------------------------------

Private Sub Update()

    Call Delete_Sheets_Not_In_Array
    Call Import_Files
    Call Add_Formulas

End Sub

'-------------------------------------------------------------------------------------------------------
' HELPER SUBS
'-------------------------------------------------------------------------------------------------------

Private Sub App_Calc()
    Application.Calculate
    If Not Application.CalculationState = xlDone Then               ' pause to calculate and do events
        DoEvents
    End If
End Sub

'-------------------------------------------------------------------------------------------------------
' DELETE OLD DATA
'-------------------------------------------------------------------------------------------------------

Private Sub Delete_Sheets_Not_In_Array()
    Dim ws    As Worksheet
    Dim wsArr As Variant

    With Application
        .ScreenUpdating = False: .Calculation = xlCalculationManual: .DisplayAlerts = False

        wsArr = Array("master")                                         ' sheets not to be deleted

        On Error Resume Next
        For Each ws In ActiveWorkbook.Worksheets
            If IsError(Application.Match(ws.Name, wsArr, 0)) Then       'delete sheets not in array
                ws.Delete
            End If
        Next ws
        On Error GoTo 0

        On Error Resume Next
        For Each ws In ActiveWorkbook.Worksheets
            If Not IsError(Application.Match(ws.Name, wsArr, 0)) Then   'clear cells from sheets in array
                With ws
                    If .AutoFilterMode Then
                        If .FilterMode Then .ShowAllData                ' clear filters
                        .Cells.Clear                                 ' clear data
                    End If
                End With


            End If
        Next ws
        On Error GoTo 0

        Call App_Calc

        .ScreenUpdating = True: .Calculation = xlCalculationAutomatic: .DisplayAlerts = True
    End With

End Sub

'-------------------------------------------------------------------------------------------------------
' IMPORT NEW DATA
'-------------------------------------------------------------------------------------------------------

Private Sub Import_Files()
    ' always end FILE_PATH with "\"
    ' all other constants can be set to any with "*"

    Const FILE_PATH As String = "\data\"
    Const FILE_NAME = "*"
    Const FILE_EXTENSION = "csv"

    Dim wbData  As Workbook
    Dim wsAct   As Worksheet
    Dim wbName  As String
    Dim fData   As String
    Dim oldDir  As String
    Dim fPrefix As String
    Dim wbNm    As String

    With Application
        .ScreenUpdating = False: .Calculation = xlCalculationManual: .DisplayAlerts = False

        Set wsAct = ActiveSheet                                         ' remember current worksheet

        wbNm = Left(ActiveWorkbook.Name, InStr(ActiveWorkbook.Name, ".") - 1)

        If wbNm = "combined_alpha" Then
            fPrefix = "lst_"                                        ' file prefix
        ElseIf wbNm = "combined_alpha" Then
            fPrefix = "lst_"
        End If

        wbName = ActiveWorkbook.Name                                    ' name of current workbook
        oldDir = CurDir                                                 ' remember current working dir
        ChDir ActiveWorkbook.Path & FILE_PATH                           ' change to directory
        fData = Dir(fPrefix & FILE_NAME & "." & FILE_EXTENSION)         ' start the file listing

        With ThisWorkbook

            On Error Resume Next
            Do While Len(fData) > 0
                If fData <> wbName Then
                    Set wbData = Workbooks.Open(fData)              ' open a file and move
                    ActiveSheet.Move After:=.Sheets(.Sheets.Count)  ' import sheet to end of sheets
                End If
                fData = Dir                                     ' ready next file
            Loop
            On Error GoTo 0

        End With

        ChDir oldDir                                                ' restore users working dir
        wsAct.Activate                                              ' return to starting sheet

        Set wbData = Nothing

        On Error Resume Next
        For Each wbData In Workbooks
            If wbData.Name <> ThisWorkbook.Name _
            Then wbData.Close savechanges:=False                    ' close any workbooks left open
            Next wbData                                                 ' from import
            On Error GoTo 0

            Call App_Calc

            .ScreenUpdating = True: .Calculation = xlCalculationAutomatic: .DisplayAlerts = True
        End With

    End Sub

    '-------------------------------------------------------------------------------------------------------
    ' ADD FORMULAS TO PULL FROM EIKON
    '-------------------------------------------------------------------------------------------------------

    Private Sub Add_Formulas()
        Dim ws    As Worksheet
        Dim wsArr As Variant
        Dim pFix  As String
        Dim lRow  As Long

        With Application
            .ScreenUpdating = False: .Calculation = xlCalculationManual: .DisplayAlerts = False

            wsArr = Array("master")
            pFix = "lst_"

            ' add formula to list sheet
            On Error Resume Next
            For Each ws In ActiveWorkbook.Worksheets
                If IsError(Application.Match(ws.Name, wsArr, 0)) Then
                    ws.Cells(1, 2).Formula = "=TR(" & pFix & "list!$A$1:(INDEX(" & pFix & "list!$A:$A,INDEX(MAX((" & pFix & "list!$A:$A<>"""")*(ROW(" & pFix & "list!$A:$A))),0))),""TR.RIC"",""CONVERTCODE:YES"")"
                End If
            Next ws
            On Error GoTo 0

            ' add formula to master sheet & add autofilter
            On Error Resume Next
            For Each ws In ActiveWorkbook.Worksheets
                If Not IsError(Application.Match(ws.Name, wsArr, 0)) Then
                    ws.Cells(2, 1).Formula = "=TR(" & pFix & "list!$B$1:(INDEX(" & pFix & "list!$B:$B,INDEX(MAX((" & pFix & "list!$B:$B<>"""")*(ROW(" & pFix & "list!$B:$B))),0))),""TR.CombinedAlphaRegionRank;TR.IVPriceToIntrinsicValueCountryListRank;TR.RelValRegionRank;TR.ARM100Region;TR.PriceMoRegionRank;TR.SHRegRank;TR.SIUnajCountryRank;TR.InsiderCtryRank;""&""TR.EQCtryRankLtst;TR.CreditComboCtryRank;TR.ValMoCountryRank"",""CH=Fd RH=IN NULL=NA"")"
                    'If Not ws.AutoFilterMode Then ws.Cells.AutoFilter
                End If
            Next ws
            On Error GoTo 0

            Call App_Calc

            .ScreenUpdating = True: .Calculation = xlCalculationAutomatic: .DisplayAlerts = True
        End With

    End Sub

    '-------------------------------------------------------------------------------------------------------
    ' DATA SORT AND FILTER
    '-------------------------------------------------------------------------------------------------------

    Private Sub Filter_and_Sort()
        Dim ws    As Worksheet
        Dim wsArr As Variant
        Dim lRow  As Long

        With Application
            .ScreenUpdating = False: .Calculation = xlCalculationManual: .DisplayAlerts = False

            wsArr = Array("master")

            On Error Resume Next
            For Each ws In ActiveWorkbook.Worksheets
                If Not IsError(Application.Match(ws.Name, wsArr, 0)) Then
                    With ws

                        If Not .AutoFilterMode Then
                            .Range("A2").AutoFilter
                        End If

                        lRow = ws.Cells(.Rows.Count, "A").End(xlUp).Row

                        .Range("A2:J" & lRow).Sort Key1:=.Range("B2"), Order1:=xlDescending, Header:=xlYes      ' sort
                        '.Range("A1:J" & lRow).AutoFilter Field:=2, Criteria1:=">=80", Operator:=xlAnd           ' filter

                    End With

                End If
            Next ws
            On Error GoTo 0

            Call App_Calc

            .ScreenUpdating = True: .Calculation = xlCalculationAutomatic: .DisplayAlerts = True
        End With

    End Sub
