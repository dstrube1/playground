   M S B A M L   `   `   `  ����
  Paster    Paster.MainWindow   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	     � Title$  Paster��5   	   $��667.224��6   $��960.452��6)   .��5
      � .+�5   
   �� $R��LPaste the code into the lower left textbox to prepare it for copy and paste.��6   $
��Left=�6g   $��10,6,0,0q�6�   $	��Top=�6�   �� 5   
   -   5        $��Prepare the Code��5      $
��Left=�6,   $��
750,10,0,0q�6G   $	��Top=�6[   $	��150��6s   6   �� 5   
   -   5        $ ��Prepare the Code W/ Quotes��5      $
��Left=�66   $��
750,30,0,0q�6Q   $	��Top=�6e   $	��150��6}   6�   �� 5   
   -   5        $!��Prepare the Code W/ Escapes��5      $
��Left=�67   $��
590,30,0,0q�6R   $	��Top=�6f   $	��150��6~   6�   �� 5   
   -   5        $��Replace \n with ____(R)��5      $
��Left=�63   $��
590,10,0,0q�6N   $	��Top=�6b   $	��150��6z   6�   �� 5   
   -   5        $��Replace ____(L) with \n��5      $
��Left=�63   $��
430,10,0,0q�6N   $	��Top=�6b   $	��150��6z   6�   �� 5   
   -   5        $��Replace��5      $
��Left=�6#   $��
430,30,0,0q�6>   $	��Top=�6R   $	��150��6j   6v   �� 5   
   -   5        $ ��Copy Right Textbox to Left��5      $
��Left=�66   $��
270,30,0,0q�6Q   $	��Top=�6e   $	��150��6}   6�   �� 5   
   -   5        $��Nothing Yet��5      $
��Left=�6'   $��
270,10,0,0q�6B   $	��Top=�6V   $	��150��6n   6z   � 5   
   $��0,50,0,0q�6    � ColumnDefinitions 5      �� 5      $	��200��6#   $	��250 �62   �� 5      $
��Auto �6#   �� 5      $��* �6#   .+�5      �� -	   5        $��leftPreview��5      $��0��6+   $��6��6;   $��1��6O   $��Code to be Prepared:��6\   $��10, -5, 0, 0q�6x   �� 5      -
   5        $��leftTextBox��5      $��0��5       $��1��5!      $��1��5"      $
��Auto��5#       �� TextWrapping$ NoWrap=�5$       �� AcceptsReturn . " �� VerticalScrollBarVisibility$
 Auto=�5&      $
��Auto��5'      $��10q�5(      �� 5*      $��1��6   $��Right=�6+   $��Stretch=�6G   $��8��6c    �� ShowsPreview . 6m   � 5+      $��2��6    5,      �� 5-      $
��Auto �6'   �� 5.      $
��Auto �6'   �� 5/      $
��Auto �6'   �� 50      $
��Auto �6'   �� 51      $
��Auto �6'   �� 52      $��* �6'    � RowDefinitions 54      �� 55      $
��Auto �6$   �� 56      $
��Auto �6$   �� 57      $
��Auto �6$   �� 58      $��* �6$   .+�5:      �� $��0��6   $��0��6,   $��
Left Text:��69   $��10q�6K   �� 5;      -   5        $��leftText��5;   �   $��1��6   $��0��6*   $	��150��67   $
��Left=�6C   $��10q�6^    �� MaxLines$ 1��6j    �� MinLines$ 1��6w   $��sb.append("��5<      �� 5A      $��4��6   $��0��6,   $��Right Text:��69   $��10q�6L   �� 5B      -   5        $��	rightText��5B   �   $��5��6   $��0��6*   $	��150��67   $
��Left=�6C   $��10q�6^   $ 1��6j   $ 1��6w   $	��");��5C      �� 5E      $��0��6   $��1��6,   $��Replace��69   $��10q�6H   �� 5F      -   5        $��replaceText��5F   j   $��1��6   $��1��6*   $	��150��67   $
��Left=�6C   $��10q�6^   6j   �� 5H      $��2��6   $��1��6,   $
��with��69   $��10q�6E   �� 5I      -   5        $��replacedText��5I   �   $��3��6   $��1��6*   $	��150��67   $
��Left=�6C   $��10q�6^   $ 1��6j   $ 1��6w   6�   �� 5N      -   5        $��	TbPreview��5N      $��0��6-   $��2��6=   $��2��6Q   $��Preview��6^   $��10, 0, 0, 0q�6m   �� 5P      -   5        $��
bigTextBox��5P      $��0��5R      $��6��5S      $��3��5T      $
��Auto��5U      $
 Wrap=�5V       . $
 Auto=�5X      $
��Auto��5Y      $��10q�5Z      ��5Q      �� 	 �� Path$	 leftTextBox�
 �� UpdateSourceTrigger$
 Explicit=�5Z      5[      5\      5]      5^      