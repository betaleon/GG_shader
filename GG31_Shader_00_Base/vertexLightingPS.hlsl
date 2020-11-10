#include "common.hlsl"

Texture2D g_Texture : register(t0);				//テクスチャ0番

SamplerState g_SamplerState : register(s0);		//サンプラー0番

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	outDiffuse = g_Texture.Sample(g_SamplerState, In.TexCoord);	//テクスチャの色を取得
	outDiffuse *= In.Diffuse;									//頂点の明るさを合成
}