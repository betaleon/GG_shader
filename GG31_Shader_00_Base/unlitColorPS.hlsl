//ピクセルシェーダー
#include "common.hlsl"

//テクスチャ
Texture2D		g_Texture : register(t0);		//テクスチャ0番を使う
//サンプラー
SamplerState	g_SamplerState : register(s0);	//サンプラー0番を使う

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
#define TEXTURECOLOR g_Texture.Sample(g_SamplerState, In.TexCoord);
	//入力された色をそのままピクセル色として出力
	//outDiffuse = In.Diffuse;
	//outDiffuse = float4(1.0f, 0.0f, 1.0f, 1.0f);

	//入力されたテクスチャ座標をもとにテクスチャ画像のピクセル色を取得して出力
	outDiffuse = g_Texture.Sample(g_SamplerState, In.TexCoord);

	//頂点の色とテクスチャの色を合成
	outDiffuse *= In.Diffuse;

	//色の反転
	/*outDiffuse = 1.0f - g_Texture.Sample(g_SamplerState, In.TexCoord);*/

	//グレースケール(ピクセルを明度0~1で表す)
	//R:G:B = 3:6:1　くらいの割合で合成する
	outDiffuse = TEXTURECOLOR;
	outDiffuse = 
		0.299*outDiffuse.r +
		0.587*outDiffuse.g +
		0.114*outDiffuse.b;

	//セピア変換
	//outDiffuse = TEXTURECOLOR;
	//outDiffuse = 0.299 * outDiffuse.r + 0.587 * outDiffuse.g + 0.114 * outDiffuse.b;
	//float4 sepia = float4(1.07, 0.74, 0.43, 1.0f);
	//outDiffuse *= sepia;


	//RGBの色を入れ替える
	//float4 color = TEXTURECOLOR;
	//outDiffuse.r = color.b;
	//outDiffuse.g = color.g;
	//outDiffuse.b = color.r;



	outDiffuse.a = 1.0f;
}