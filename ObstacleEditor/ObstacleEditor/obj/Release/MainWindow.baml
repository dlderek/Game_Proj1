   M S B A M L   `   `   `  ����   ObstacleEditor    ObstacleEditor.MainWindow   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     -     �Name$
  Main�� � Title$ 障礙物編輯器��$	��628��$
��1000�����	#FFF1F1F1 � WindowStyle$ 
ToolWindow=� � 
ResizeMode$ CanMinimize=�.��� ���	#FFE0E0E0$��0,0,0,5q� � ColumnDefinitions �� .+��� $��場景��$
��Left=�$��
162,11,0,0q�$	��Top=��� -    ��Name$ 
btn_export��$��匯出��$
��Left=�$��909,567,0,0q�$	��Top=�$��75��
��������� -   $ 
btn_import��$��匯入��$
��Left=�$��829,567,0,0q�$	��Top=�$��75��
��������� -   $ 	btn_reset��$��重置��$
��Left=�$��
41,546,0,0q�$	��Top=�$��75��
��������� -    ��Name$ block1��$
��Left=�$	��100��$��
388,42,0,0q�$	��Top=�$	��100�� � Cursor$
 Hand��$��UniformToFill=� J� Effect 3  -System.Windows.Media.Effects.DropShadowEffect  �� -   $ block2��$
��Left=�$	��100��$��
493,42,0,0q�$	��Top=�$	��100��$
 Hand��$��UniformToFill=�   �� -   $ block3��$
��Left=�$	��100��$��
598,42,0,0q�$	��Top=�$	��100��$
 Hand��$��UniformToFill=�   �� -   $ block4��$
��Left=�$	��100��$��
703,42,0,0q�$	��Top=�$	��100��$
 Hand��$��UniformToFill=�   �� -	   $ block5��$
��Left=�$	��100��$��388,147,0,0q�$	��Top=�$	��100��$
 Hand��$��UniformToFill=�   �� -
   $ block6��$
��Left=�$	��100��$��493,152,0,0q�$	��Top=�$	��100��$
 Hand��$��UniformToFill=�   �� -   $ block7��$
��Left=�$	��100��$��593,152,0,0q�$	��Top=�$	��100��$
 Hand��$��UniformToFill=�   �� -   $ block8��$
��Left=�$	��100��$��703,147,0,0q�$	��Top=�$	��100��$
 Hand��$��UniformToFill=�   �� $��0��$
��Left=�$��	41,11,0,0q�$	��Top=��� $	��600��$
��Left=�$��
314,11,0,0q�$	��Top=��� -   $ 	btn_front��$��^��$
��Left=�$��365,457,0,0q�$	��Top=�$��16��$��36���� -   $ btn_back��$��v��$
��Left=�$��365,509,0,0q�$	��Top=�$��16��$��36���� $��置頂��$
��Left=�$��386,463,0,0q�$	��Top=��� $��置底��$
��Left=�$��386,514,0,0q�$	��Top=��� -   	 ��Name$		 top��$��0��$
��Left=�$��	10,40,0,0q�$	��Top=��� -   $	 bottom��$
��1000��$
��Left=�$��	3,516,0,0q�$	��Top=��� -   $ 
btn_remove��$��x��$
��Left=�$��365,402,0,0q�$	��Top=�$��16��$��36���� $��移除��$
��Left=�$��386,407,0,0q�$	��Top=��� -   
 ��Name$
 StageSlider��$
��Left=�$��
83,280,0,0q�$	��Top=�$	��500�� J� RenderTransformOrigin$ 0.5,0.5&� � Maximum$	 500Q�z�V� .~��� �� ��  �� Angle$ 90Q�T� �� -    ��Name$ StageContainer��$
��Left=�$	��500��$��	41,40,0,0q�$	��Top=�$	��270��}�. ����  �� EndPoint$ 0.5,1&� �� 
StartPoint$ 0.5,0&�.���  � Color$ Black�� � Offset$ 1Q�� $ 	LightGray��.+��� -   $ 
background��$
��Left=�$	��500��$	��Top=�$	��270��$��UniformToFill=��� -   $ Stage��$
��Left=�$
��1000��$	��Top=�$	��270��}�.  J� SnapsToDevicePixels . �� -   $ 	character��$
��Left=�$��72��$��441,402,0,0q�$	��Top=�$��66��$
 Hand��$��UniformToFill=��� -   $ btn_background��$��插入背景��$
��Left=�$��128,546,0,0q�$	��Top=�$��75��
��������� -   $ 
collection��$
��Left=�$	��100��$��388,252,0,0q�$	��Top=�$	��100��$
 Hand��$��UniformToFill=�   