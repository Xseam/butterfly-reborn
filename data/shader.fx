texture Tex;

technique hure
{
    pass P0
    {
        Texture[0] = Tex;
		AlphaBlendEnable = TRUE;
    }
}
