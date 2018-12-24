Attribute VB_Name = "func_core_040_actionscamp"
'-----------------------------------------------
'ģ�鹦��:
'   ��ģ�����ڷ���zhazhupai006�еĿ�ִ�е�actioncamp
' a=action
'-----------------------------------------------

Public Sub X8()
'�����ܣ�
'   �ճ���
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
End Sub


Public Sub a_AddOne(Whichcount As String)
'�����ܣ�
'   Ϊcountԭ�е�ֵ����1
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Call cs_AddOne(Whichcount)
End Sub

Public Sub a_ReduceOne(Whichcount As String)
'�����ܣ�
'   Ϊcountԭ�е�ֵ����1
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Call cs_RedOne(Whichcount)
End Sub

Public Sub a_BeZero(Whichcount As String)
'�����ܣ�
'   ����count��ֵΪ0
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Call cs_BeZero(Whichcount)
End Sub

Public Sub a_BeOne(Whichcount As String)
'�����ܣ�
'   ����count��ֵΪ1
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Call cs_BeOne(Whichcount)
End Sub

Public Sub a_ShapeShow(PS As String)
    '���ܣ�
    '   ��ʾ��ע��which����ͼ����
    '�汾��
    '   1.0
    'ÿһ���޶���
    '   1.0 >>> ԭʼ�汾
        On Error Resume Next
        For Each ashape In ActiveSheet.Shapes
            If Left(ashape.TextFrame2.TextRange.Characters.Text, 3) = PS Then
                ashape.Visible = True
            End If
        Next
End Sub

Public Sub a_ShapeHide()
    '���ܣ�
    '   ���ر�ע
    '�汾��
    '   1.0
    'ÿһ���޶���
    '   1.0 >>> ԭʼ�汾
        On Error Resume Next
        For Each ashape In ActiveSheet.Shapes
            If Left(ashape.TextFrame2.TextRange.Characters.Text, 2) = "PS" Then
                ashape.Visible = False
            End If
        Next
End Sub
Public Sub a_OpenOne()
    '���ܣ�
    '   ����one�����ܱ���
    '�汾��
    '   1.0
    'ÿһ���޶���
    '   1.0 >>> ԭʼ�汾
    Call cs_WV("Open Engine", "Y")
    Application.StatusBar = "...ONE�Ѿ���"
End Sub

Public Sub a_CloseOne()
    '���ܣ�
    '   ����one���治�ܱ���
    '�汾��
    '   1.0
    'ÿһ���޶���
    '   1.0 >>> ԭʼ�汾
    Call cs_WV("Open Engine", "N")
    Application.StatusBar = "...one�Ѿ��ر�"
End Sub

Public Sub a_OpenActions()
    '���ܣ�
    '   ��ִ�ж�������
    '�汾��
    '   1.0
    'ÿһ���޶���
    '   1.0 >>> ԭʼ�汾
    Call cs_WV("Actions", "Y")
    Application.StatusBar = "...���������Ѿ���"
End Sub

Public Sub a_CloseActions()
    '���ܣ�
    '   �ر�ִ�ж�������
    '�汾��
    '   1.0
    'ÿһ���޶���
    '   1.0 >>> ԭʼ�汾
    Call cs_WV("Actions", "N")
    Application.StatusBar = "...���������Ѿ��ر�"
End Sub

Public Sub a_IniExcelName()
'�����ܣ�
'   ��excel��������������֣�д�� setup
'����汾��
'   1.0
'   1.1
'�汾�޶���
'   1.0 >>> ԭʼ�汾
'   1.1 >>> ����excel 2016 365 excel ���ֻ���Щ�ı䣬ԭ���ĳ���ò��������������Ҫ�Ľ����롣
    PotentialName1 = ActiveWorkbook.Name & " - Excel"
    PotentialName2 = ActiveWorkbook.Name & " - Saved"
    PotentialName3 = Left(ActiveWorkbook.Name, Len(ActiveWorkbook.Name) - 5) & " - Excel"
    PotentialName4 = Left(ActiveWorkbook.Name, Len(ActiveWorkbook.Name) - 5) & " - Saved"
    If Val(cs_FindWnd(PotentialName1)) > 0 Then
        RealName = PotentialName1
    ElseIf Val(cs_FindWnd(PotentialName2)) > 0 Then
        RealName = PotentialName2
    ElseIf Val(cs_FindWnd(PotentialName3)) > 0 Then
        RealName = PotentialName3
    ElseIf Val(cs_FindWnd(PotentialName4)) > 0 Then
        RealName = PotentialName4
    Else
        MsgBox "Contact this smart person: 15026846502"
        Exit Sub
    End If
    ExcelName = RealName
    Call cs_WV("ACAK file name", ExcelName)

End Sub

Public Sub a_SimpleExcel(Optional pro As String)
'�����ܣ�
'   �Ƿ�򵥻�excelsheetҳ����ʾ ��������ȥ����һ������
'����汾��
'   1.0
'   1.1
'�汾�޶���
'   1.0 >>> ԭʼ�汾
'   1.1 >>> �°汾��������ֵ���ڵ���ҳ��
TrueOrFalse = cs_FV("displaymode", "core_display_setup", "C", "D")
If pro = "pro" Then
    TrueOrFalse = "pro"
End If
Select Case TrueOrFalse
    Case "pro"
        Application.ExecuteExcel4Macro "SHOW.TOOLBAR(""Ribbon"",True)"
        Application.DisplayFormulaBar = True
        Application.DisplayStatusBar = True
        ActiveWindow.DisplayWorkbookTabs = True
        ActiveWindow.DisplayHeadings = True
        ActiveWindow.DisplayHorizontalScrollBar = True
        ActiveWindow.DisplayVerticalScrollBar = True
    Case "simple"
        Application.ExecuteExcel4Macro "SHOW.TOOLBAR(""Ribbon"",False)"
        Application.DisplayFormulaBar = False
        Application.DisplayStatusBar = False
        ActiveWindow.DisplayWorkbookTabs = False
        ActiveWindow.DisplayHeadings = False
        ActiveWindow.DisplayHorizontalScrollBar = False
        ActiveWindow.DisplayVerticalScrollBar = False
End Select
End Sub

Public Sub a_ShowExcelSize(MinNormalMax As String)
'�����ܣ�
'   ��󻯣���С����������excel����
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Select Case MinNormalMax
        Case "Min"
            Application.WindowState = xlMinimized
        Case "Normal"
            Application.WindowState = xlNormal
        Case "Max"
            Application.WindowState = xlMaximized
    End Select
End Sub

Public Sub a_ShowPage(PageName As String)
'�����ܣ�
'   ��ʾָ����sheet,ͬʱ����welcomepage��homepage������ҳ����
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
For i = 1 To Sheets.Count
    If Sheets(i).Name <> "core_screen" And Sheets(i).Name <> "core_homepage" Then
        Sheets(i).Visible = 0
    Else
        Sheets(i).Visible = 1
    End If
Next
For i = 1 To Sheets.Count
    If Sheets(i).Name = PageName Then
        Sheets(i).Visible = 1
        Sheets(i).Select
        Call a_SimpleExcel   '���´���ʱ�򣬼����Ҫ�󴰿ڵ���ʽ
    End If
Next
End Sub

Public Sub a_CheckFolder()
''�����ܣ�
''   ���ָ�����ļ����Ƿ���ڣ��������򴴽�
''����汾��
''   1.0
''�汾�޶���
''   1.0 >>> ԭʼ�汾
    Dim excelpath As String
    excelpath = ThisWorkbook.path
    folder01 = cs_FV("Logfolder")
    folderpath01 = excelpath & folder01
    If Dir(folderpath01, vbDirectory) = "" Then MkDir folderpath01
    
    folder02 = cs_FV("picfolder")
    folderpath02 = excelpath & folder02
    If Dir(folderpath02, vbDirectory) = "" Then MkDir folderpath02
End Sub

Public Sub a_LogInTXT()
'�����ܣ�
'   ��log ҳ��������ݼ��뵽TXT�У�logҳ���
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Dim excelpath As String
    excelpath = ThisWorkbook.path
    folder = cs_FV("Logfolder")
    Dim logpath As String
    Dim logname As String
    Dim PageName As String
    Dim RowE As Long
    logpath = excelpath & folder
    logname = Application.Text(Now(), "yyyymmddhhmmss") & ".txt"
    logpath = logpath & logname
    PageName = cs_FV("LogSheet")
    RowE = Sheets(PageName).Range("B150000").End(xlUp).Row
    If RowE > 1 Then
        Open logpath For Output As #1
        For i = 1 To RowE
            S = Sheets(PageName).Range("B" & i).Value
            Print #1, S
            Sheets(PageName).Range("B" & i).Value = ""
        Next
        Close #1
        Range("B" & 2 & ":B" & RowE + 1).ClearContents
    End If
End Sub

Public Sub a_initialM00()
'�����ܣ�
'   ��M00 �е�ֵ��0
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
Dim i As Long
Dim ColN As Long
Dim ColS As Long
Dim Row2M0 As Long
Dim Row4M0 As Long
Dim PageName02 As String
PageName02 = cs_FV("ScreenSheet")
ColN = cs_FV("M01 Cols")
ColS = cs_FV("M01 Col Start Number")
Row2M0 = cs_FV("M00 ROW TOTAL") '��¼M00�� ����ȫ�ֿ�ִ�д�����������
Row4M0 = cs_FV("M00 ROW ONE") '��¼M00�� ���е��ο�ִ�д�����������
For i = ColS To ColS + ColN - 1
    Sheets(PageName02).Cells(Row4M0, i).Value = 0
Next
For i = ColS To ColS + ColN - 1
    Sheets(PageName02).Cells(Row2M0, i).Value = 0
Next
End Sub

Public Sub a_changeOneLoppNumber(loopnumber As Long)
'�����ܣ�
'   ����one�������������
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
Call cs_WV("Engine Loop", loopnumber)
End Sub



Public Sub a_MouseMove(ByVal x As Long, ByVal y As Long, ByVal ttime As Long)
Call MouseMove(x, y, ttime)
End Sub
Public Sub a_MouseClick(ByVal L0R1 As String, ByVal ttime As Long)
Call MouseClick(L0R1, ttime)
End Sub
Public Sub a_SendKeyss(keys As String)
Call SendKeyss(keys)
End Sub
