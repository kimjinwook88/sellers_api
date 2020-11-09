package com.uni.sellers.common;

import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class CommonMailEventGui extends JFrame{

	private static final long serialVersionUID = -711163588504124217L;

	public void calendarEventGui() {
		//	  super("초대 일정 추가하기.");

		setBounds(200 , 100 , 300 , 120);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		Container contentPane = this.getContentPane();
		JPanel pane = new JPanel();
		JButton buttonStart = new JButton("확인");
		//	  JTextField textPeriod = new JTextField(5);
		JLabel labelPeriod = new JLabel("일정 초대를 수락하였습니다.");
		JLabel labelPeriod2 = new JLabel("The Seller's 캘린더에 일정을 추가하였습니다.");

		buttonStart.setMnemonic('확');

		pane.add(labelPeriod);
		pane.add(labelPeriod2);
		pane.add(buttonStart);
		//	  pane.add(textPeriod);
		contentPane.add(pane);

		setVisible(true);

		buttonStart.addActionListener(new ActionListener(){

			@Override
			public void actionPerformed(ActionEvent e) {
				dispose();
			}

		});

	}
}
