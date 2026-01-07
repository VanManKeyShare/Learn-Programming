
// CSharp - C# -> CONVERT IMAGE TO BASE64 AND BASE64 TO IMAGE

namespace CONVERT_IMAGE_TO_BASE64_AND_BASE64_TO_IMAGE
{
	public string Image_To_Base64(System.Drawing.Image Image)
	{
		using (System.IO.MemoryStream MS = new System.IO.MemoryStream())
		{
			Image.Save(MS, System.Drawing.Imaging.ImageFormat.Png);
			byte[] Image_Bytes = MS.ToArray();
			return Convert.ToBase64String(Image_Bytes);
		}
	}

	public System.Drawing.Image Base64_To_Image(string Base64_String)
	{
		try
		{
			byte[] Image_Bytes = Convert.FromBase64String(Base64_String);
			System.IO.MemoryStream ms = new System.IO.MemoryStream(Image_Bytes, 0, Image_Bytes.Length);
			ms.Write(Image_Bytes, 0, Image_Bytes.Length);
			System.Drawing.Image image = System.Drawing.Image.FromStream(ms, true);
			return image;
		}
		catch (Exception ex)
		{
			Console.WriteLine(ex.ToString());
			return null;
		}
	}

	public System.Drawing.Image Resize_Image(System.Drawing.Image Img, int Width, int Height)
	{
		System.Drawing.Bitmap Bm = new System.Drawing.Bitmap(Width, Height);
		System.Drawing.Graphics Gp = System.Drawing.Graphics.FromImage((System.Drawing.Image)Bm);
		Gp.DrawImage(Img, 0, 0, Width, Height);
		Gp.Dispose();
		return (System.Drawing.Image)Bm;
	}

	private void Btn_Choose_File_Click(object sender, EventArgs e)
	{
		openFileDialog1.Filter = "IMAGE FILES (*.BMP;*.JPG;*.GIF;*.PNG)|*.BMP;*.JPG;*.GIF;*.PNG";
		openFileDialog1.FileName = "";
		openFileDialog1.ShowDialog();
		if (openFileDialog1.FileName != ""){
			PictureBox1.Image = Resize_Image(new Bitmap(openFileDialog1.FileName), 120, 120);
		}
	}

	private void Btn_Image_To_Base64_Click(object sender, EventArgs e)
	{
		if (PictureBox1.Image != null){
			TextBox1.Text = Image_To_Base64(PictureBox1.Image);
		}
	}

	private void Btn_Base64_To_Image_Click(object sender, EventArgs e)
	{
		if (TextBox1.Text != ""){
			PictureBox2.Image = Base64_To_Image(TextBox1.Text);
		}
	}

}
