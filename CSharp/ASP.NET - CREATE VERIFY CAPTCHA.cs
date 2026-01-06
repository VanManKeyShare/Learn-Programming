
// CSharp - C# - ASP.NET -> CREATE AND VERIFY CAPTCHA

using System;
using System.Drawing;
using System.Drawing.Text;

namespace MMManager
{
    public class VMK_CAPTCHA
    {
        public string _KEY_CAPTCHA = "CODE";
        public string _KEY_TIMEOUT = "TIMEOUT";
        public string _KEY_SESSION = "CAPTCHA";

        public int _FONT_SIZE = 12;
        public string _FONT_NAME = "Arial Bold";
        public Brush _FONT_COLOR = Brushes.White;
        public Color _BACKGROUND_COLOR = Color.Green;
        public FontStyle _FONT_STYLE = FontStyle.Bold;

        public int _PADDING_TOP = 5;
        public int _PADDING_LEFT = 5;
        public int _PADDING_RIGHT = 5;
        public int _PADDING_BOTTOM = 4;

        public int _CAPTCHA_LENGTH = 1;
        public double _TIMEOUT_IN_SECONDS = 60;

        public string _CHARACTERS_LISTS_FOR_RANDOM = "123456789ABCDEFGHJKLMNOPQRSTUVWXYZ";

        public Bitmap VMK_CREATE_CAPTCHA()
        {
            // CREATE RANDOM STRING
            string rSTRING = VMK_MAIN.VMK_RANDOM_STRING(_CHARACTERS_LISTS_FOR_RANDOM, _CAPTCHA_LENGTH);

            // CREATE FONT OBJECT
            Font oFONT = new Font(_FONT_NAME, _FONT_SIZE, _FONT_STYLE, GraphicsUnit.Point);

            // CALCULATE THE WIDTH AND HEIGHT OF A STRING
            Graphics oGraphics = Graphics.FromImage(new Bitmap(1, 1));
            SizeF oSize = oGraphics.MeasureString(rSTRING, oFONT);

            // EXTRACT THE WIDTH AND HEIGHT OF A STRING
            int IMG_WIDTH = (int)Math.Round(oSize.Width, 0);
            int IMG_HEIGHT = (int)Math.Round(oSize.Height, 0);

            // THE WIDTH AND HEIGHT + PADDING
            IMG_WIDTH += (_PADDING_RIGHT * 2);
            IMG_HEIGHT += (_PADDING_BOTTOM * 2);

            // CREATE IMAGE WITH THE NEW WIDTH AND HEIGHT
            Bitmap oBMP = new System.Drawing.Bitmap(IMG_WIDTH, IMG_HEIGHT);
            oGraphics = System.Drawing.Graphics.FromImage(oBMP);

            oGraphics.Clear(_BACKGROUND_COLOR);
            oGraphics.TextRenderingHint = TextRenderingHint.AntiAlias;

            oGraphics.DrawString(rSTRING, oFONT, _FONT_COLOR, _PADDING_LEFT, _PADDING_TOP);

            // SAVE CAPTCHA STRING TO SESSION
            VMK_MAIN.VMK_Session(_KEY_SESSION, "SET", _KEY_CAPTCHA, rSTRING);
            VMK_MAIN.VMK_Session(_KEY_SESSION, "SET", _KEY_TIMEOUT, (VMK_MAIN.CREATE_SECONDS_FROM_DATETIME_NOW() + _TIMEOUT_IN_SECONDS).ToString());

            oFONT.Dispose();
            oGraphics.Dispose();
            // oBMP.Dispose();

            return oBMP;
        }

        public int VMK_VERIFY_CAPTCHA(string CODE, string _KEY_SESSION, string _KEY_CAPTCHA, string _KEY_TIMEOUT)
        {
            string CAPTCHA_CODE_FROM_SESSION = VMK_MAIN.VMK_Session(_KEY_SESSION, "GET", _KEY_CAPTCHA);
            string TIMEOUT_FROM_SESSION = VMK_MAIN.VMK_Session(_KEY_SESSION, "GET", _KEY_TIMEOUT);

            if (CAPTCHA_CODE_FROM_SESSION == null || TIMEOUT_FROM_SESSION == null)
            {
                // CAPTCHA CODE HAS NOT YET CREATED
                return -2;
            }

            double CURRENT_DATETIME_TO_SECONDS = VMK_MAIN.CREATE_SECONDS_FROM_DATETIME_NOW();
            double TIMEOUT_TEMP = Convert.ToDouble(TIMEOUT_FROM_SESSION);

            if ((CURRENT_DATETIME_TO_SECONDS - TIMEOUT_TEMP) > 0)
            {
                // CAPTCHA CODE HAS EXPIRED
                return -1;
            }

            // CLEAN CAPTCHA FROM SESSION
            VMK_MAIN.VMK_Session(_KEY_SESSION, "CLEAN");

            if (CAPTCHA_CODE_FROM_SESSION == CODE) { return 1; }

            // CAPTCHA CODE HAS BEEN WRONG
            return 0;
        }
    }
}
