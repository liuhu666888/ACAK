Attribute VB_Name = "func_core_020_ifcamp"
'-----------------------------------------------
'ģ�鹦��:
'   ��ģ�����ڷ���zhazhupai006�еĸ�Ӧ�ӿڵĿ���
'   if=interface
'-----------------------------------------------
Public Sub if_IFonCo(WhichRange As String, WhichCountTimely As String, WhichCountBenchmark As String)
'�����ܣ�
'   eye�ӿڣ����WhichCountTimely >= WhichCountBenchmark,��Ӧ��ֵΪ1����֮��Ϊ0
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
Dim page02 As String
Dim CountTimely As Integer
Dim CountBenchmark As Integer
Dim Range01 As String
page02 = cs_FV("ScreenSheet")
CountTimely = cs_FindValue(WhichCountTimely)
CountBenchmark = cs_FindValue(WhichCountBenchmark)
With Sheets(page02)
        .Range(WhichRange).Interior.Color = 6710784
        If CountTimely < CountBenchmark Then
        '����в�ͬ��ָʾ��Ϊ��ɫ
            .Range(WhichRange).Interior.Color = 192
            .Range(WhichRange).Value = 0
        Else
        '��ͬΪ��ɫ
            .Range(WhichRange).Interior.Color = 5296274
            .Range(WhichRange).Value = 1
        End If
End With
End Sub

