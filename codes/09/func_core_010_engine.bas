Attribute VB_Name = "func_core_010_engine"
'-----------------------------------------------
'ģ�鹦��:
'   ��ģ�����ڷ���zhazhupai006�еķ�����one
'   c=core
'-----------------------------------------------

Public Sub c_one()
'�����ܣ�
'   ������������
'   �Ƿ������� ��0��һ���ܱ����У�֮�� one���濪�عر�>��������ת�����Ѿ��ﵽ=δ�ҵ�����ִ�е���>���д����Ѿ��ﵽ
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
Dim AA As String
Dim x As Integer
Dim y As Integer
Dim i As Integer
Dim n As Long
Dim m As Long
Dim RowS As Integer
Dim RowE As Integer
Dim Vrow As Integer
Dim PageName02 As String  'screen sheet
Dim PageName03 As String  'engine setup sheet
Dim ActionsCamp As String  'actions in which vba module
Dim EngYN As String
Dim BehYN As String
Dim EngLoopNumber As Long
Vrow = cs_FV("VinScreenRow")
PageName02 = cs_FV("ScreenSheet")
PageName03 = cs_FV("EngineSetupSheet")
ActionsCamp = cs_FV("ActionsInWhichVBAModule")
RowS = cs_FV("M02 Row Start Number")
RowSS = cs_FV("M02 Rows") '�õ��ж���ָ����Ҫ����
EngLoopNumber = cs_FV("Engine Loop")
For n = 0 To EngLoopNumber + 1
    Select Case n
        Case 0 ' ��0�����У���ʼ������
            Call cs_TakeAction(PageName03, "D")
        Case 1 To EngLoopNumber ' ��1������ �� �涨�������У���������
            EngYN = cs_FV("Open Engine") '���������Ƿ������
            BehYN = cs_FV("Actions") '���������ܷ�ִ�ж�Ӧ����������
            If EngYN = "Y" Then
                Call cs_AddOne("count01")                           'ACAK�򿪺� one�������д���
                Call cs_AddOne("count02")                           'one���·��������д���
                Call c_IFController   '����ÿ���ӿڳ���
                T03 = Timer
                Sheets(PageName02).Range("G" & Vrow & ":AG" & Vrow).ClearContents '"V"���������
                x = c_GetRightColInM01() '�ҳ���V��Ӧ������һ�У�������������к�
                Call cs_Log("Total " & Str((Timer - T03)), "Info") '�鿴�ҵ���ȷ�е�ʱ��
                y = c_IfRightColInM01ShouldRun(x) '�����ṩ���кţ��ж��Ƿ��Ѿ�������һ������д���
                If x > 0 And y > 0 And BehYN = "Y" Then '��������
                        T06 = Timer
                        For i = RowS To RowS + RowSS - 1
                            Sheets(PageName02).Range(num2asc2(x) & i).Interior.Color = 192
                            Application.StatusBar = Sheets(PageName02).Range(num2asc2(x) & i).Value
                             AA = "'" & ActionsCamp & "." & Cells(i, x) & "'"
                             T05 = Timer
                            Application.Run AA '���г���
                            Call cs_Log(Sheets(PageName02).Range(num2asc2(x) & i).Value & " ��ʱ�� " & Str((Timer - T05)), "Info")
                            Application.StatusBar = ""
                            Sheets(PageName02).Range(num2asc2(x) & i).Interior.Color = 16777215
                            DoEvents
                        Next
                        Call cs_Log(num2asc2(x) & "�ж��� ��ʱ�� " & Str((Timer - T06)), "Info")
                        
                ElseIf x > 0 And y > 0 And BehYN = "N" Then '����������
                    Application.StatusBar = "������Ϊ������������ִ�С�"
                ElseIf x < 0 Or y = 0 Then
                    Application.StatusBar = "����01���Ҳ�����Ӧ���л��߶�Ӧ���г��������һѭ��������û�ж�������ִ�С�"
                    Exit For
                End If
            Else
                Application.StatusBar = "...ONE�����Ѿ��ر�"
                Exit For
            End If
        Case EngLoopNumber + 1
        End Select
    m = m + 1
Next
If m = EngLoopNumber + 2 Then
    Application.StatusBar = "one�����Ѿ��ﵽ���õ����ѭ���������������С�"
    Call cs_TakeAction(PageName03, "H")
End If
End Sub

Public Function c_GetRightColInM01() As Integer
'�����ܣ�
'   ͨ���Ա����Ľ������matrix01���ҵ���Ӧ��ֵ,���ڶ�Ӧ����ͷ�ϱ����V"
'����汾��
'   1.1
'�汾�޶���
'   1.0 >>> ԭʼ�汾,������ɫ���
Dim x As Integer
Dim i As Integer
Dim ii As Integer
Dim ix As Integer
Dim n As Integer
Dim max As Integer
Dim IFColN As Integer
Dim VRowN As Integer
Dim RowN As Integer
Dim ColN As Integer
Dim RowS As Integer
Dim ColS As Integer
Dim JudgeWay As Integer
Dim Arr01() As Integer
Dim PageName02 As String
IFColN = cs_FV("IFdisplayinScreenCol")
VRowN = cs_FV("VinScreenRow")
RowN = cs_FV("M01 Rows")
ColN = cs_FV("M01 Cols")
RowS = cs_FV("M01 Row Start Number")
ColS = cs_FV("M01 Col Start Number")
JudgeWay = cs_FV("EngineColumnSelectMethod")
PageName02 = cs_FV("ScreenSheet")
If JudgeWay = 1 Then
    x = 0
    n = 0
    For i = 0 To ColN - 1
        ix = c_CompareTwoWordInM01(IFColN, ColS + i, RowS, RowS + RowN - 1)(1)
        If ix = 1 Then
            Sheets(PageName02).Cells(VRowN, ColS + i).Value = "V"
            x = 1
            Exit For
        End If
    Next
    If x = 1 Then
        c_GetRightColInM01 = ColS + i
    Else
        c_GetRightColInM01 = -1
    End If
    
ElseIf JudgeWay = 2 Then
            x = 0
            n = 0
            max = 0
            ReDim Arr01(ColN - 1)
        '----------------------------------
        'ȷ���з�����������
            For i = 0 To ColN - 1
                ix = c_CompareTwoWordInM01(IFColN, ColS + i, RowS, RowS + RowN - 1)(1)
                If ix = 1 Then
                    x = 1
                    Exit For
                End If
            Next
        '-----------------------------------
            For i = 0 To ColN - 1
                Arr01(i) = c_CompareTwoWordInM01(IFColN, ColS + i, RowS, RowS + RowN - 1)(2)
            Next
        '-----------------------------------
            max = Arr01(0)
            For i = 0 To ColN - 2
                If max < Arr01(i + 1) Then
                    max = Arr01(i + 1)
                End If
            Next
        '-----------------------------------
            For i = 0 To ColN - 1
                If Arr01(i) = max Then
                    ii = i
                    Exit For
                End If
            Next
            If x = 1 And max >= 0 Then
                Sheets(PageName02).Cells(VRowN, ColS + ii).Value = "V"
                c_GetRightColInM01 = ColS + ii
            Else
                c_GetRightColInM01 = -1
            End If

End If
End Function

Public Function c_CompareTwoWordInM01(WhichColNum01 As Integer, WhichColNum02 As Integer, U As Integer, L As Integer) As Integer()
'�����ܣ�
'   �ԱȾ���01�е����У������8�����������һ�·���1�������һ�·���0
'����汾��
'   1.1
'�汾�޶���
'   1.0 >>> ԭʼ�汾,������ɫ���
    Dim PageName02 As String
    PageName02 = cs_FV("ScreenSheet")
    Dim A As String
    Dim B As String
    Dim C(1 To 2) As Integer
    Dim HowLong As Integer
    Dim i As Integer
    For i = 0 To L - U
        If Sheets(PageName02).Cells(U + i, WhichColNum01).Value <> 8 And Sheets(PageName02).Cells(U + i, WhichColNum02).Value <> 8 Then
            A = A & Trim((Str(Sheets(PageName02).Cells(U + i, WhichColNum01).Value)))
            B = B & Trim((Str(Sheets(PageName02).Cells(U + i, WhichColNum02).Value)))
            HowLong = HowLong + 1
        End If
    Next
    If A = B Then
        C(1) = 1
        C(2) = HowLong
    Else
        C(1) = 0
        C(2) = -1
    End If
    c_CompareTwoWordInM01 = C
End Function

Public Function c_IfRightColInM01ShouldRun(x As Integer)
'�����ܣ�
'   �����ͬһ����û�г����涨�Ĵ�����û�з���1���з���0��ͬʱͳ�ƴ�����ͳ�ƴ����������һ��Ҳ����ͬ�е���������ۼӣ���Ķ���0
'����汾��
'   1.1
'�汾�޶���
'   1.0 >>> ԭʼ�汾,������ɫ���

Dim i As Long
Dim guodu As Long
Dim RowN As Long
Dim ColN As Long
Dim RowS As Long
Dim ColS As Long
Dim PageName02 As String
Dim Row1M0 As Long
Dim Row2M0 As Long
Dim Row3M0 As Long
Dim Row4M0 As Long
Dim M00Fuction1 As String
Dim M00Fuction2 As String
Dim A As Integer
Dim B As Integer
Dim a_1 As Integer
Dim b_1 As Integer
A = 1
B = 1
quanju = 0
a_1 = 1
b_1 = 1
RowN = cs_FV("M01 Rows")
ColN = cs_FV("M01 Cols")
RowS = cs_FV("M01 Row Start Number")
ColS = cs_FV("M01 Col Start Number")
PageName02 = cs_FV("ScreenSheet")

Row1M0 = cs_FV("M00 ROW TOTAL MAX") '�ж�M00�� ����ȫ�ֿ�ִ�д��������������
Row2M0 = cs_FV("M00 ROW TOTAL") '��¼M00�� ����ȫ�ֿ�ִ�д�����������
Row3M0 = cs_FV("M00 ROW ONE MAX") '�ж�M00�� ���е��ο�ִ�д��������������
Row4M0 = cs_FV("M00 ROW ONE") '��¼M00�� ���е��ο�ִ�д�����������
M00Fuction1 = cs_FV("M00 Judge TOTAL MAX") ' �Ƿ������ж� Total max�� Y or N
M00Fuction2 = cs_FV("M00 Judge ONE MAX") ' �Ƿ������ж� ONE max�� Y or N

If x > 0 Then
    If M00Fuction2 = "Y" Then
        If Sheets(PageName02).Cells(Row4M0, x).Value < Sheets(PageName02).Cells(Row3M0, x).Value Then
            a_1 = 1
        Else
            a_1 = 0
        End If
    End If
    If M00Fuction1 = "Y" Then
        If Sheets(PageName02).Cells(Row2M0, x).Value < Sheets(PageName02).Cells(Row1M0, x).Value Then
            b_1 = 1
        Else
            b_1 = 0
        End If
    End If
    If M00Fuction2 = "Y" Then
        If Sheets(PageName02).Cells(Row4M0, x).Value < Sheets(PageName02).Cells(Row3M0, x).Value And a_1 * b_1 = 1 Then
            Sheets(PageName02).Cells(Row2M0, x).Value = Sheets(PageName02).Cells(Row2M0, x).Value + 1
            quanju = 1
            guodu = Sheets(PageName02).Cells(Row4M0, x).Value + 1
            For i = ColS To ColS + ColN - 1
                Sheets(PageName02).Cells(Row4M0, i).Value = 0
            Next
            Sheets(PageName02).Cells(Row4M0, x).Value = guodu
            A = 1
        Else
            A = 0
        End If
    End If
    If M00Fuction1 = "Y" Then
        If Sheets(PageName02).Cells(Row2M0, x).Value < Sheets(PageName02).Cells(Row1M0, x).Value And a_1 * b_1 = 1 Then
            If quanju = 0 Then
                Sheets(PageName02).Cells(Row2M0, x).Value = Sheets(PageName02).Cells(Row2M0, x).Value + 1
            End If
            B = 1
        Else
            B = 0
        End If
    End If
    If A * B = 1 Then
        c_IfRightColInM01ShouldRun = 1
    Else
        c_IfRightColInM01ShouldRun = 0
    End If
ElseIf x < 0 Then
    c_IfRightColInM01ShouldRun = 0
End If
End Function

Public Sub c_IFController()
'�����ܣ�
'   ѡ�� ����-homepage-�ӿ� ҳ�� judge��һ������ִ�нӿڳ���
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    Dim PageName02 As String
    Dim PageName03 As String
    Dim PageName04 As String
    Dim Range01 As String
    PageName02 = cs_FV("ScreenSheet")
    PageName03 = cs_FV("IFSheet")
    PageName04 = cs_FV("IFInWhichVBAModule")
    Range01 = cs_FV("ShowStatusInWhichCellInScreenSheet")
    T = Timer
    With Sheets(PageName03)
        For i = 2 To .Range("a1000").End(xlUp).Row
            Call cs_ShowJobStatus(Range01, 0)
            If .Range("D" & i).Value = 1 Then
                T2 = Timer
                AA = "'" & PageName04 & "." & .Range("b" & i) & "'"
                Application.Run AA
                DoEvents
                Call cs_Log(AA & " " & Str((Timer - T2)), "Info")
            Else
                Sheets(PageName02).Range(.Range("A" & i).Value).Interior.Color = 6250335
                Sheets(PageName02).Range(.Range("A" & i).Value).Value = 0
                DoEvents
            End If
            Call cs_ShowJobStatus(Range01, 1)
        Next
    End With
    Call cs_Log(" IF Total : " & Str((Timer - T)), "Info")
End Sub
