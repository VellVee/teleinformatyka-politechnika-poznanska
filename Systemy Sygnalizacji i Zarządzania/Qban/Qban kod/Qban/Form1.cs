// Decompiled with JetBrains decompiler
// Type: Form1.Form1
// Assembly: Kaban, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9AECCFA3-73DB-498E-920E-F77538729A37
// Assembly location: C:\Users\adamp\Desktop\Qban.exe

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;

namespace Form1
{
  public class Form1 : Form
  {
    public static List<question> QuE = new List<question>();
    public int index = 0;
    public string atm_correct = "";
    public int correct = 0;
    public int wrong = 0;
    public Random R = new Random(DateTime.Now.Millisecond);
    private IContainer components = (IContainer) null;
    public DateTime start;
    public DateTime end;
    private Button button1;
    private Button button2;
    private Button button3;
    private Button button4;
    private TextBox textBox1;
    private RichTextBox richTextBox1;
    private TextBox textBox2;
    private TextBox textBox3;
    private TextBox textBox4;
    private Label label1;
    private Label label2;
    private Label correct_label;
    private Label wrong_label;
    private Label ilosc;
    private Label label3;
    private Label percent;
    private Label label5;
    private Button button5;
    private Timer timer1;
    private Label time_label;

    public Form1()
    {
      this.InitializeComponent();
      this.generate_questions();
      this.shuffle_questions();
      this.set_question();
    }

    public void shuffle_questions()
    {
        int n = QuE.Count;
        while (n > 1)
        {
            n--;
            int k = R.Next(n + 1);
            question value = QuE[k];
            QuE[k] = QuE[n];
            QuE[n] = value;
        }
    }

    public void update_label()
    {
      this.correct_label.Text = this.correct.ToString();
      this.wrong_label.Text = this.wrong.ToString();
      Label ilosc = this.ilosc;
      int num = this.index + 1;
      string str1 = num.ToString();
      string str2 = " / ";
      num = Form1.QuE.Count;
      string str3 = num.ToString();
      string str4 = str1 + str2 + str3;
      ilosc.Text = str4;
      try
      {
        this.percent.Text = ((double) (100 * this.correct / (this.correct + this.wrong))).ToString() + "%";
      }
      catch (DivideByZeroException ex)
      {
        this.percent.Text = "0%";
      }
    }

    public void set_question()
    {
      try
      {
        if (100 * this.correct / (this.correct + this.wrong) > 50)
          this.percent.ForeColor = Color.Green;
        else
          this.percent.ForeColor = Color.Red;
      }
      catch (Exception ex)
      {
      }
      this.update_label();
      if (this.index >= Form1.QuE.Count)
      {
        double num1 = (double) (100 * this.correct / (this.correct + this.wrong));
        this.end = DateTime.Now;
        string str = "Uzyskany czas: " + (this.end - this.start).Minutes.ToString() + " min " + (object) (this.end - this.start).Seconds + " sec";
        if (num1 < 50.0)
        {
          int num2 = (int) MessageBox.Show("Twoj wynik to " + (object) num1 + "%\nMusisz jeszcze pocwiczyc\n\n" + str, "Nie zdales", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
        }
        else
        {
          int num3 = (int) MessageBox.Show("Twoj wynik to " + (object) num1 + "%\nYOU FOKIN GOOD\n\n" + str, "Brawo zdales", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
        }
        this.correct = 0;
        this.wrong = 0;
        this.index = 0;
        this.update_label();
        this.timer1.Stop();
        this.time_label.Text = "0 min 0 sec";
      }
      if (this.index == 1)
      {
        this.start = DateTime.Now;
        this.timer1.Start();
      }
      question question = Form1.QuE.ElementAt<question>(this.index);
      this.textBox1.Text = question.ans.ElementAt<answer>(0).text.ToString();
      this.textBox2.Text = question.ans.ElementAt<answer>(1).text.ToString();
      this.textBox3.Text = question.ans.ElementAt<answer>(2).text.ToString();
      this.textBox4.Text = question.ans.ElementAt<answer>(3).text.ToString();
      this.richTextBox1.Text = question.text;
      this.atm_correct = question.correct;
    }

    public void generate_questions()
    {
      StreamReader streamReader = new StreamReader(Directory.GetCurrentDirectory() + "\\question.txt");
      for (string str1 = ""; !(str1 == "==="); str1 = streamReader.ReadLine())
      {
        question question = new question();
        question.text = streamReader.ReadLine();
        answer[] answerArray1 = new answer[4];
        string txt1 = streamReader.ReadLine();
        answerArray1[0] = new answer(txt1);
        answerArray1[0].ans_id = "a";
        string txt2 = streamReader.ReadLine();
        answerArray1[1] = new answer(txt2);
        answerArray1[1].ans_id = "b";
        string txt3 = streamReader.ReadLine();
        answerArray1[2] = new answer(txt3);
        answerArray1[2].ans_id = "c";
        string txt4 = streamReader.ReadLine();
        answerArray1[3] = new answer(txt4);
        answerArray1[3].ans_id = "d";
        string str2 = streamReader.ReadLine();
        question.correct = str2;
        switch (str2)
        {
          case "a":
            answerArray1[0].correct = true;
            question.correct = "a";
            break;
          case "b":
            answerArray1[1].correct = true;
            question.correct = "b";
            break;
          case "c":
            answerArray1[2].correct = true;
            question.correct = "c";
            break;
          case "d":
            answerArray1[3].correct = true;
            question.correct = "d";
            break;
        }
        int[] numArray1 = new int[4];
        int[] numArray2 = this.combinations(4, 3);
        answer[] answerArray2 = new answer[4];
        for (int index = 0; index < 4; ++index)
          answerArray2[numArray2[index]] = answerArray1[index];
        for (int index = 0; index < 4; ++index)
          question.ans.Add(answerArray2[index]);
        Form1.QuE.Add(question);
      }
      streamReader.Close();
    }

    public int[] combinations(int how_many, int max_index)
    {
      int[] numArray1 = new int[max_index + 1];
      int length = how_many;
      int index1 = 0;
      for (int index2 = 0; index2 < numArray1.Length; ++index2)
        numArray1[index2] = index2;
      int[] numArray2 = new int[length];
      for (; length > 0; --length)
      {
        int index2 = this.R.Next(0, numArray1.Length - index1 - 1);
        numArray2[index1] = numArray1[index2];
        numArray1[index2] = numArray1[numArray1.Length - index1 - 1];
        numArray1[numArray1.Length - index1 - 1] = numArray2[index1];
        ++index1;
      }
      return numArray2;
    }

    public void show_correct()
    {
      if (Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(0).correct)
      {
        int num1 = (int) MessageBox.Show("Correct answer a:\n" + Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(0).text, "WRONG BUTTON", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
      }
      else if (Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(1).correct)
      {
        int num2 = (int) MessageBox.Show("Correct answer b:\n" + Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(1).text, "WRONG BUTTON", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
      }
      else if (Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(2).correct)
      {
        int num3 = (int) MessageBox.Show("Correct answer c:\n" + Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(2).text, "WRONG BUTTON", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
      }
      else
      {
        if (!Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(3).correct)
          return;
        int num4 = (int) MessageBox.Show("Correct answer d:\n" + Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(3).text, "WRONG BUTTON", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
      }
    }

    private void button1_Click(object sender, EventArgs e)
    {
      if (Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(0).correct)
      {
        ++this.correct;
      }
      else
      {
        ++this.wrong;
        this.show_correct();
      }
      ++this.index;
      this.set_question();
    }

    private void button2_Click(object sender, EventArgs e)
    {
      if (Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(1).correct)
      {
        ++this.correct;
      }
      else
      {
        ++this.wrong;
        this.show_correct();
      }
      ++this.index;
      this.set_question();
    }

    private void button3_Click(object sender, EventArgs e)
    {
      if (Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(2).correct)
      {
        ++this.correct;
      }
      else
      {
        ++this.wrong;
        this.show_correct();
      }
      ++this.index;
      this.set_question();
    }

    private void button4_Click(object sender, EventArgs e)
    {
      if (Form1.QuE.ElementAt<question>(this.index).ans.ElementAt<answer>(3).correct)
      {
        ++this.correct;
      }
      else
      {
        ++this.wrong;
        this.show_correct();
      }
      ++this.index;
      this.set_question();
    }

    public void autor_info()
    {
      int num = (int) MessageBox.Show("Autorem programu jest Sacra", "Informacje o autorze", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
    }

    private void button1_KeyDown(object sender, KeyEventArgs e)
    {
      if (e.KeyValue != 112)
        return;
      this.autor_info();
    }

    private void button5_Click(object sender, EventArgs e)
    {
      this.index = 0;
      this.wrong = 0;
      this.correct = 0;
      this.set_question();
      this.timer1.Stop();
      this.time_label.Text = "0 min 0 sec";
      this.percent.ForeColor = Color.Red;
    }

    private void timer1_Tick(object sender, EventArgs e)
    {
      this.end = DateTime.Now;
      this.time_label.Text = (this.end - this.start).Minutes.ToString() + " min " + (object) (this.end - this.start).Seconds + " sec";
    }

    protected override void Dispose(bool disposing)
    {
      if (disposing && this.components != null)
        this.components.Dispose();
      base.Dispose(disposing);
    }

    private void InitializeComponent()
    {
      this.components = (IContainer) new Container();
      this.button1 = new Button();
      this.button2 = new Button();
      this.button3 = new Button();
      this.button4 = new Button();
      this.textBox1 = new TextBox();
      this.richTextBox1 = new RichTextBox();
      this.textBox2 = new TextBox();
      this.textBox3 = new TextBox();
      this.textBox4 = new TextBox();
      this.label1 = new Label();
      this.label2 = new Label();
      this.correct_label = new Label();
      this.wrong_label = new Label();
      this.ilosc = new Label();
      this.label3 = new Label();
      this.percent = new Label();
      this.label5 = new Label();
      this.button5 = new Button();
      this.timer1 = new Timer(this.components);
      this.time_label = new Label();
      this.SuspendLayout();
      this.button1.BackColor = SystemColors.GradientActiveCaption;
      this.button1.FlatStyle = FlatStyle.Flat;
      this.button1.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.button1.Location = new Point(14, 120);
      this.button1.Name = "button1";
      this.button1.Size = new Size(87, 27);
      this.button1.TabIndex = 0;
      this.button1.Text = "a";
      this.button1.UseVisualStyleBackColor = false;
      this.button1.Click += new EventHandler(this.button1_Click);
      this.button1.KeyDown += new KeyEventHandler(this.button1_KeyDown);
      this.button2.BackColor = SystemColors.GradientActiveCaption;
      this.button2.FlatStyle = FlatStyle.Flat;
      this.button2.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.button2.Location = new Point(14, 155);
      this.button2.Name = "button2";
      this.button2.Size = new Size(87, 27);
      this.button2.TabIndex = 1;
      this.button2.Text = "b";
      this.button2.UseVisualStyleBackColor = false;
      this.button2.Click += new EventHandler(this.button2_Click);
      this.button2.KeyDown += new KeyEventHandler(this.button1_KeyDown);
      this.button3.BackColor = SystemColors.GradientActiveCaption;
      this.button3.FlatStyle = FlatStyle.Flat;
      this.button3.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.button3.Location = new Point(14, 189);
      this.button3.Name = "button3";
      this.button3.Size = new Size(87, 27);
      this.button3.TabIndex = 2;
      this.button3.Text = "c";
      this.button3.UseVisualStyleBackColor = false;
      this.button3.Click += new EventHandler(this.button3_Click);
      this.button3.KeyDown += new KeyEventHandler(this.button1_KeyDown);
      this.button4.BackColor = SystemColors.GradientActiveCaption;
      this.button4.FlatStyle = FlatStyle.Flat;
      this.button4.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.button4.Location = new Point(14, 224);
      this.button4.Name = "button4";
      this.button4.Size = new Size(87, 27);
      this.button4.TabIndex = 3;
      this.button4.Text = "d";
      this.button4.UseVisualStyleBackColor = false;
      this.button4.Click += new EventHandler(this.button4_Click);
      this.button4.KeyDown += new KeyEventHandler(this.button1_KeyDown);
      this.textBox1.BackColor = SystemColors.Control;
      this.textBox1.BorderStyle = BorderStyle.None;
      this.textBox1.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, (byte) 238);
      this.textBox1.Location = new Point(108, 125);
      this.textBox1.Name = "textBox1";
      this.textBox1.Size = new Size(572, 13);
      this.textBox1.TabIndex = 4;
      this.textBox1.Text = "question content";
      this.textBox1.KeyDown += new KeyEventHandler(this.button1_KeyDown);
      this.richTextBox1.Font = new Font("Microsoft Sans Serif", 9f, FontStyle.Regular, GraphicsUnit.Point, (byte) 238);
      this.richTextBox1.Location = new Point(14, 44);
      this.richTextBox1.Name = "richTextBox1";
      this.richTextBox1.Size = new Size(665, 69);
      this.richTextBox1.TabIndex = 5;
      this.richTextBox1.Text = "1\n2\n3";
      this.richTextBox1.KeyDown += new KeyEventHandler(this.button1_KeyDown);
      this.textBox2.BackColor = SystemColors.Control;
      this.textBox2.BorderStyle = BorderStyle.None;
      this.textBox2.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, (byte) 238);
      this.textBox2.Location = new Point(108, 160);
      this.textBox2.Name = "textBox2";
      this.textBox2.Size = new Size(572, 13);
      this.textBox2.TabIndex = 6;
      this.textBox2.Text = "question content";
      this.textBox2.KeyDown += new KeyEventHandler(this.button1_KeyDown);
      this.textBox3.BackColor = SystemColors.Control;
      this.textBox3.BorderStyle = BorderStyle.None;
      this.textBox3.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, (byte) 238);
      this.textBox3.Location = new Point(108, 195);
      this.textBox3.Name = "textBox3";
      this.textBox3.Size = new Size(572, 13);
      this.textBox3.TabIndex = 7;
      this.textBox3.Text = "question content";
      this.textBox3.KeyDown += new KeyEventHandler(this.button1_KeyDown);
      this.textBox4.BackColor = SystemColors.Control;
      this.textBox4.BorderStyle = BorderStyle.None;
      this.textBox4.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, (byte) 238);
      this.textBox4.Location = new Point(108, 228);
      this.textBox4.Name = "textBox4";
      this.textBox4.Size = new Size(572, 13);
      this.textBox4.TabIndex = 8;
      this.textBox4.Text = "question content";
      this.textBox4.KeyDown += new KeyEventHandler(this.button1_KeyDown);
      this.label1.AutoSize = true;
      this.label1.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.label1.Location = new Point(15, 15);
      this.label1.Name = "label1";
      this.label1.Size = new Size(48, 13);
      this.label1.TabIndex = 9;
      this.label1.Text = "Correct";
      this.label2.AutoSize = true;
      this.label2.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.label2.Location = new Point(122, 15);
      this.label2.Name = "label2";
      this.label2.Size = new Size(44, 13);
      this.label2.TabIndex = 10;
      this.label2.Text = "Wrong";
      this.correct_label.AutoSize = true;
      this.correct_label.Location = new Point(70, 15);
      this.correct_label.Name = "correct_label";
      this.correct_label.Size = new Size(14, 15);
      this.correct_label.TabIndex = 11;
      this.correct_label.Text = "0";
      this.wrong_label.AutoSize = true;
      this.wrong_label.Location = new Point(174, 15);
      this.wrong_label.Name = "wrong_label";
      this.wrong_label.Size = new Size(14, 15);
      this.wrong_label.TabIndex = 12;
      this.wrong_label.Text = "0";
      this.ilosc.AutoSize = true;
      this.ilosc.Location = new Point(438, 15);
      this.ilosc.Name = "ilosc";
      this.ilosc.Size = new Size(14, 15);
      this.ilosc.TabIndex = 13;
      this.ilosc.Text = "0";
      this.label3.AutoSize = true;
      this.label3.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.label3.Location = new Point(225, 15);
      this.label3.Name = "label3";
      this.label3.Size = new Size(72, 13);
      this.label3.TabIndex = 14;
      this.label3.Text = "Percentage";
      this.percent.AutoSize = true;
      this.percent.ForeColor = Color.Red;
      this.percent.Location = new Point(316, 15);
      this.percent.Name = "percent";
      this.percent.Size = new Size(14, 15);
      this.percent.TabIndex = 15;
      this.percent.Text = "0";
      this.label5.AutoSize = true;
      this.label5.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.label5.Location = new Point(362, 15);
      this.label5.Name = "label5";
      this.label5.Size = new Size(57, 13);
      this.label5.TabIndex = 16;
      this.label5.Text = "Question";
      this.button5.BackColor = Color.FromArgb((int) byte.MaxValue, 128, 128);
      this.button5.FlatStyle = FlatStyle.Flat;
      this.button5.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.button5.Location = new Point(633, 9);
      this.button5.Name = "button5";
      this.button5.Size = new Size(44, 25);
      this.button5.TabIndex = 17;
      this.button5.Text = "RST";
      this.button5.UseVisualStyleBackColor = false;
      this.button5.Click += new EventHandler(this.button5_Click);
      this.timer1.Tick += new EventHandler(this.timer1_Tick);
      this.time_label.AutoSize = true;
      this.time_label.Font = new Font("Microsoft Sans Serif", 9f, FontStyle.Bold, GraphicsUnit.Point, (byte) 238);
      this.time_label.Location = new Point(518, 15);
      this.time_label.Name = "time_label";
      this.time_label.Size = new Size(81, 15);
      this.time_label.TabIndex = 18;
      this.time_label.Text = "0 min 0 sec";
      this.AutoScaleDimensions = new SizeF(7f, 15f);
      this.AutoScaleMode = AutoScaleMode.Font;
      this.BackColor = SystemColors.Control;
      this.ClientSize = new Size(689, 261);
      this.Controls.Add((Control) this.time_label);
      this.Controls.Add((Control) this.button5);
      this.Controls.Add((Control) this.label5);
      this.Controls.Add((Control) this.percent);
      this.Controls.Add((Control) this.label3);
      this.Controls.Add((Control) this.ilosc);
      this.Controls.Add((Control) this.wrong_label);
      this.Controls.Add((Control) this.correct_label);
      this.Controls.Add((Control) this.label2);
      this.Controls.Add((Control) this.label1);
      this.Controls.Add((Control) this.textBox4);
      this.Controls.Add((Control) this.textBox3);
      this.Controls.Add((Control) this.textBox2);
      this.Controls.Add((Control) this.richTextBox1);
      this.Controls.Add((Control) this.textBox1);
      this.Controls.Add((Control) this.button4);
      this.Controls.Add((Control) this.button3);
      this.Controls.Add((Control) this.button2);
      this.Controls.Add((Control) this.button1);
      this.Font = new Font("Microsoft Sans Serif", 9f, FontStyle.Regular, GraphicsUnit.Point, (byte) 238);
      this.FormBorderStyle = FormBorderStyle.FixedToolWindow;
      this.Name = nameof (Form1);
      this.Text = "Qban 1.1";
      this.ResumeLayout(false);
      this.PerformLayout();
    }
  }
}
