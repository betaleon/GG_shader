//ピクセルシェーダー
#include "common.hlsl"

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	//入力された色をそのままピクセル色として出力
	outDiffuse = In.Diffuse;

}