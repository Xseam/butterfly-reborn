texture screenSource;
float cr = 1;
float cg = 1;
float cb = 1;
float pX = 1;
float pY = 1;

sampler screen = sampler_state
{
    Texture = (screenSource);
};

float4 pixelShader ( float2 Tex : TEXCOORD0 ) : COLOR0
{

    float4 pix = tex2D(screen,Tex);
	float4 pc;
	Tex = Tex - pY;
	pc = tex2D(screen,Tex-pX); pix += pc;
    pc = tex2D(screen,Tex);    pix += pc;
    pc = tex2D(screen,Tex+pX); pix += pc;
    Tex = Tex + pY;
    pc = tex2D(screen,Tex-pX); pix += pc;
    pc = tex2D(screen,Tex+pX); pix += pc;
    Tex = Tex + pY;
    pc = tex2D(screen,Tex-pX); pix += pc;
    pc = tex2D(screen,Tex);    pix += pc;
    pc = tex2D(screen,Tex+pX); pix += pc;
	pix.r = pix.r/9*cr;
	pix.g = pix.g/9*cg;
	pix.b = pix.b/9*cb;
	
	return pix;
}

technique theRealMothafuckinBlur
{
	pass P0
	{
		VertexShader = null;
		PixelShader = compile ps_2_0 pixelShader ( );
	}
}
