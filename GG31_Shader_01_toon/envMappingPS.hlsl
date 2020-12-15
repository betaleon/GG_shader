#include "common.hlsl"

Texture2D g_Texture : register(t0);
//Texture2D g_ToonTexture : register(t1);//テクスチャ1番を使う
Texture2D g_TextureEnv : register(t1);
SamplerState g_SamplerState : register(s0);

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	float4 normal = normalize(In.Normal);						//回転後の法線を正規化する
	float light = -dot(normal.xyz, Light.Direction.xyz) ;

	//このピクセルの法線マップのデータRGBAを取得
	float4 normalMap = g_TextureEnv.Sample(g_SamplerState, In.TexCoord);

	//取得したRGBAをベクトルXYZWへ戻す
	normalMap = -(normalMap * 2.0f - 1.0f);


	//カメラからピクセルへのベクトル
	float3 eyev = In.WorldPosition.xyz - CameraPosition.xyz;
	eyev = normalize(eyev);	//正規化する

	//--------------------------------------------//
	//				フォン鏡面反射				  //
	//--------------------------------------------//
	//法線で向きを表す面で反射したベクトルの計算
	float3 refv = reflect(Light.Direction.xyz, normal.xyz);	//光の反射ベクトルを計算
	refv = normalize(refv);	//正規化する


	//環境マッピング
	float2 envTexCoord;	//テクスチャ座標
	envTexCoord.x = -refv.x * 0.3f + 0.5f;
	envTexCoord.y = -refv.y * 0.3f + 0.5f;

	float specular = -dot(eyev, refv);	//鏡面反射の計算
	specular = saturate(specular);		//値をサチュレート
	specular = pow(specular, 30);		//ここでは30乗してみる

	outDiffuse = g_TextureEnv.SampleBias(g_SamplerState, envTexCoord, 0.0);

	outDiffuse.rgb += specular;	//スペキュラをディフューズとして足しこむ

	outDiffuse.a = 1.0f;

}