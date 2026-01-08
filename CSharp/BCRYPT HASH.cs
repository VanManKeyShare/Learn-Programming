// CSharp - C# -> BCRYPT HASH

namespace VMK_BCRYPT_HASH
{
    private async void CREATE_BCRYPT_HASH_Click(object sender, EventArgs e)
    {
        string Password = TPassword.Text;

        // KIỂM TRA ĐẦU VÀO CƠ BẢN
        if (string.IsNullOrEmpty(Password)) return;

        // VÔ HIỆU HÓA NÚT BẤM ĐỂ TRÁNH NGƯỜI DÙNG NHẤN LIÊN TỤC KHI ĐANG XỬ LÝ
        var BTN = (Button)sender;
        BTN.Enabled = false;

        try
        {
            // CHẠY TÁC VỤ BĂM MẬT KHẨU TRÊN MỘT LUỒNG NỀN (BACKGROUND THREAD)
            int WorkFACTOR = 12;
            string Hash = await Task.Run(() => BCrypt.Net.BCrypt.EnhancedHashPassword(Password, WorkFACTOR));

            TBCRYPT_HASH.Text = Hash;
        }
        finally
        {
            // KÍCH HOẠT LẠI NÚT BẤM
            BTN.Enabled = true;
        }
    }

    private async void VERIFY_BCRYPT_HASH_Click(object sender, EventArgs e)
    {
        string Password = TPassword.Text;
        string Hash = TBCRYPT_HASH.Text;

        if (string.IsNullOrEmpty(Password) || string.IsNullOrEmpty(Hash)) return;

        var BTN = (Button)sender;
        BTN.Enabled = false;

        try
        {
            // CHẠY TÁC VỤ KIỂM TRA MẬT KHẨU TRÊN LUỒNG NỀN
            bool isMATCH = await Task.Run(() => BCrypt.Net.BCrypt.EnhancedVerify(Password, Hash));

            if (isMATCH)
                MessageBox.Show("MẬT KHẨU CHÍNH XÁC!", "THÔNG BÁO", MessageBoxButtons.OK, MessageBoxIcon.Information);
            else
                MessageBox.Show("MẬT KHẨU KHÔNG KHỚP!", "THÔNG BÁO", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
        catch (Exception ex)
        {
            MessageBox.Show($"CÓ LỖI XẢY RA: {ex.Message}", "THÔNG BÁO", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
        finally
        {
            BTN.Enabled = true;
        }
    }
}
