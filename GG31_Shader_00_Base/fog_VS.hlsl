/*
#include "common.hlsl"

void main(	in float4 inPosition   : POSITION0,
			in float4 inNormal     : NORMAL0,
			in float4 inDiffuse	   : COLOR0,
			in float2 inTexCoord   : TEXCOORD0,
	
			out float2 outTexCoord : TEXCOORD0,
			out float4 outDiffuse  : COLOR0,
			out float4 outPosition : SV_POSITION,
			out float4 outNormal   : NORMAL0,
			out float  outDepth    : DEPTH)
{
	matrix wvp;
	wvp = mul(World, View);
	wvp = mul(wvp, Projection);				//変換行列作成

	outPosition = mul(inPosition, wvp);		//頂点を変換して出力
	outNormal = inNormal;
	outTexCoord = inTexCoord;

	outDepth = 1 - saturate((50 - outPosition.w) / (50 - 0.1F));

	//float4 worldNormal, normal;				//法線をワールド行列で回転
	//normal = float4(In.Normal.xyz, 0.0f);
	//worldNormal = mul(normal, World);
	//
	//worldNormal = normalize(worldNormal);	//変換した法線を正規化
	//Out.Normal = worldNormal;				//ワールド変換した法線を出力
	//
	//Out.Diffuse = In.Diffuse;
	//Out.TexCoord = In.TexCoord;
	//
	//Out.WorldPosition = mul(In.Position, World);	//ワールド 変換した頂点座標を 出力
}*/