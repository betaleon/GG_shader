#include "common.hlsl"

Texture2D g_Texture : register(t0);
SamplerState g_SamplerState : register(s0);

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	float4 normal = normalize(In.Normal);						//回転後の法線を正規化する
	float light = -dot(normal.xyz, Light.Direction.xyz) ;

	//テクスチャのピクセル色を取得
	outDiffuse = g_Texture.Sample(g_SamplerState, In.TexCoord);
	outDiffuse.rgb *= In.Diffuse.rgb*light;	//頂点色と明るさを乗算
	outDiffuse.a *= In.Diffuse.a;			//aに明るさは関係ないので別計算

	//カメラからピクセルへのベクトル
	float3 eyev = In.WorldPosition.xyz - CameraPosition.xyz;
	eyev = normalize(eyev);	//正規化する

	//--------------------------------------------//
	//				フォン鏡面反射				  //
	//--------------------------------------------//
	//法線で向きを表す面で反射したベクトルの計算
	float3 refv = reflect(Light.Direction.xyz, normal.xyz);	//光の反射ベクトルを計算
	refv = normalize(refv);	//正規化する
	
	float specular = -dot(eyev, refv);	//鏡面反射の計算
	specular = saturate(specular);		//値をサチュレート
	specular = pow(specular, 50);		//ここでは30乗してみる
	
	outDiffuse.rgb += specular;	//スペキュラをディフューズとして足しこむ

}