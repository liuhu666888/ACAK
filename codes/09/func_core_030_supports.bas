Attribute VB_Name = "func_core_030_supports"
'-----------------------------------------------
'ģ�鹦��:
'   ��ģ�����ڷ���zhazhupai006�е�֧�ָ��ֳ������е�һЩ����С����
'   cs=core support
'   if=interface sensor
'-----------------------------------------------
Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Public Function cs_FV(Ipt As Variant, Optional WhichSheet As String = "core_setup", Optional WhichCol01 As String = "F", _
                Optional WhichCol02 As String = "G", Optional HowManyRows As Long = 1000) As Variant
'�����ܣ�
'   ͨ��ָ�����е�ֵ��������ָ�����е�ֵ
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Dim i As Integer
    Dim x As Long
    Dim n As Integer
    With Sheets(WhichSheet)
        For x = 1 To .Range(WhichCol01 & HowManyRows).End(xlUp).Row
            If .Range(WhichCol01 & x).Value = Ipt Then
                cs_FV = .Range(WhichCol02 & x).Value
                Exit For
            End If
        Next
    End With
End Function
Public Sub cs_WV(Ipt As Variant, Wpt As Variant, Optional WhichSheet As String = "core_setup", Optional WhichCol01 As String = "F", _
                Optional WhichCol02 As String = "G", Optional HowManyRows As Long = 1000)
'�����ܣ�
'   ͨ��ָ�����е�ֵIpt��д������ָ�����е�ֵWpt
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Dim i As Integer
    Dim x As Long
    Dim n As Integer

    With Sheets(WhichSheet)
        For x = 1 To .Range(WhichCol01 & HowManyRows).End(xlUp).Row
            If .Range(WhichCol01 & x).Value = Ipt Then
                    .Range(WhichCol02 & x).Value = Wpt
                Exit For
            End If
        Next
    End With
End Sub

Public Sub cs_AddOne(Whichcount As String)
'�����ܣ�
'   д������ҳ��� whichcount �Աߵ���ֵ��1
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Dim MiddleCount As Long
    MiddleCount = cs_FV(Whichcount, "core_count", "A", "B")
    Call cs_WV(Whichcount, MiddleCount + 1, "core_count", "A", "B")
End Sub
Public Sub cs_RedOne(Whichcount As String)
'�����ܣ�
'   д������ҳ��� whichcount �Աߵ���ֵ��1
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Dim MiddleCount As Long
    MiddleCount = cs_FV(Whichcount, "core_count", "A", "B")
    Call cs_WV(Whichcount, MiddleCount - 1, "core_count", "A", "B")
End Sub

Public Sub cs_BeZero(Whichcount As String)
'�����ܣ�
'   д������ҳ��� whichcount �Աߵ���ֵ���0
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Call cs_WV(Whichcount, 0, "core_count", "A", "B")
End Sub

Public Sub cs_BeOne(Whichcount As String)
'�����ܣ�
'   д������ҳ��� whichcount �Աߵ���ֵ���1
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Call cs_WV(Whichcount, 1, "core_count", "A", "B")
End Sub

Public Sub cs_BeValue(Whichcount As String, Value As Variant)
'�����ܣ�
'   д������ҳ��� whichcount �Աߵ���ֵ���value
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Call cs_WV(Whichcount, Value, "core_count", "A", "B")
End Sub

Public Function cs_FindValue(Whichcount As String) As Variant
'�����ܣ�
'   ���ֵ�whichcount �Աߵ���ֵ
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    cs_FindValue = cs_FV(Whichcount, "core_count", "A", "B")
End Function


Public Sub cs_TakeAction(whichpagename As String, whichcol As String, Optional RowS As Integer = 2)
'�����ܣ�
'   ��ĳҳ��ĳ�ж��� ����ִ��
'����汾��
'   1.1
'�汾�޶���
'   1.0 >>> ԭʼ�汾,������ɫ���
'   1.1 >>> ��״̬����ʾ����
    Dim RowE As Integer
    Dim AA As String
    Dim i As Integer
    Dim ActionsCamp As String  'actions in which vba module
    RowE = Sheets(whichpagename).Range(whichcol & 10000).End(xlUp).Row
    ActionsCamp = cs_FV("ActionsInWhichVBAModule")
    For i = RowS To RowE
        AA = "'" & ActionsCamp & "." & Sheets(whichpagename).Range(whichcol & i).Value & "'"
        Application.StatusBar = AA
        Application.Run AA
        DoEvents
    Next
End Sub

Public Sub cs_Log(sts As Variant, level_Debug_Error_Print_Info As String)
'�����ܣ�
'   ��¼sts��core_log��
'����汾��
'   1.0
'   1.1
'�汾�޶���
'   1.0 >>> ԭʼ�汾
'   1.1 >>> ����һ������ ȷ�� ����ʲô����¼�¼log
    Dim PageName As String
    Dim A As Long
    Dim B As String
    PageName = cs_FV("LogSheet")
    Call cs_AddOne("count03")
    A = cs_FindValue("count03") + 1
    B = Now() & " " & level_Debug_Error_Print_Info & " " & sts
    Sheets(PageName).Range("B" & A).Value = B
End Sub

Public Sub cs_ShowJobStatus(Optional ShowStatusInWhichCell As String = "I6", Optional w0d1 As Integer = 0)
    Dim PageName02 As String
    PageName02 = cs_FV("ScreenSheet")
    With Sheets(PageName02).Range(ShowStatusInWhichCell)
        If w0d1 = 0 Then
            .Value = "Working"
        Else
            .Value = "Done"
        End If
    End With
End Sub


Public Function cs_FindWnd(ByVal wName As String) As Long
'�����ܣ�
'   ���ݸ����Ĵ�������wName�õ���Ӧ�Ĵ�������
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
On Error GoTo error1
    If Val(Application.Version) < 9 Then
        cs_FindWnd = FindWindow("ThunderXFrame", wName) 'XL97
    Else
        cs_FindWnd = FindWindow("ThunderDFrame", wName) 'XL2000
    End If
    If cs_FindWnd = 0 Then cs_FindWnd = FindWindow(vbNullString, wName)
    Call cs_Log(Now() & " FindWnd��" & "���壺 " & wName & " ���:  " & cs_FindWnd, "Debug")
    Exit Function
error1:
    Call cs_Log(Now() & " FindWnd��������", "Error")
End Function



