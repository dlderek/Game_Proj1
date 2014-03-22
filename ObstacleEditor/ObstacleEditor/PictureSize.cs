using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ObstacleEditor
{
    public static class PictureSize
    {
        public static Dictionary<string, object[]> picSize = new Dictionary<string, object[]>();
        public static void Init()
        {
            picSize.Add("block1", new object[] { 88, 22 });
            picSize.Add("block2", new object[] { 93, 34 });
            picSize.Add("block3", new object[] { 93, 22 });
            picSize.Add("block4", new object[] { 121, 98 });
            picSize.Add("block5", new object[] { 121, 98 });
            picSize.Add("block6", new object[] { 173, 192 });
            picSize.Add("block7", new object[] { 173, 192 });
            picSize.Add("block8", new object[] { 162, 177 });
            picSize.Add("collection", new object[] { 80, 69 });
            picSize.Add("character", new object[] { 43, 33 });
        }
    }
}
