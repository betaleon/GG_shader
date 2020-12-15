#include "common.hlsl"

void main(in VS_IN In, out PS_IN Out)
{
	//wvp ワールドビュープロジェクション
	matrix wvp;
	wvp = mul(World, View);
	wvp = mul(wvp, Projection);				//変換行列作成

	Out.Position = mul(In.Position, wvp);	//頂点を変換して出力
	//法線をワールド行列で変換
	float4 worldNormal, normal;				//法線をワールド行列で回転
	normal = float4(In.Normal.xyz, 0.0f);
	worldNormal = mul(normal, World);

	worldNormal = normalize(worldNormal);	//変換した法線を正規化
	Out.Normal = worldNormal;				//ワールド変換した法線を出力

	Out.Diffuse = In.Diffuse;
	Out.TexCoord = In.TexCoord;

	Out.WorldPosition = mul(In.Position, World);	//ワールド 変換した頂点座標を 出力
}