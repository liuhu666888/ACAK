Attribute VB_Name = "functions_general_tools"
'-----------------------------------------------
'ģ�鹦��:
'   ��ģ�����ڷ�������xlsm�������õĳ���
'-----------------------------------------------

Function num2asc2(ByVal n As Integer) As String
'�����ܣ�
'   �������ַ���Ӣ����ĸ
'����汾��
'   1.0
'�汾�޶���
'   1.0 >>> ԭʼ�汾
    num2asc2 = Mid(Cells(1, n).Address, 2, IIf(n < 27, 1, 2))
End Function
