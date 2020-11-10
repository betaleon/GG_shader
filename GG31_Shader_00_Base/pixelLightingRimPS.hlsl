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
	//				リムライティング				  //
	//--------------------------------------------//
	float rim = 1.0 + dot(eyev, normal.xyz); //視線と法線の内積を明るさに変換する
	rim = pow(rim, 3) * 2.0f; //スペキュラと同じような処理を適当に行う。
	rim = saturate(rim); //rimをサチュレートする
	outDiffuse.rgb += rim; //通常の色へ加算する。
	outDiffuse.a = In.Diffuse.a;
}