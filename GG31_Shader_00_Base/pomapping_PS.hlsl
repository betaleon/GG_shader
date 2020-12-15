#include "common.hlsl"

Texture2D g_Texture			: register(t0);
Texture2D g_TextureNormal   : register(t1);						//法線マップ
SamplerState g_SamplerState : register(s0);
sampler g_Texture1			: register(s1);

void main(in PS_IN In, out float4 outDiffuse : SV_Target)
{
	//このピクセルの法線マップのデータRGBAを取得
	float4 normalMap = g_TextureNormal.Sample(g_SamplerState, In.TexCoord);

	//取得したRGBAをベクトルXYZWへ戻す
	normalMap = normalMap * 2.0f - 1.0f;

	//テクスチャのデータを法線用変数へ入れ替え
	float3 normal;
	normal.x = normalMap.x;
	normal.y = normalMap.y;
	normal.z = normalMap.z;
	normal = normalize(normal);	//正規化

	//以下はフォンとかブリンフォンとかの光源計算

	float light = dot(normal.xyz, Light.Direction.xyz);
	light += 0.5f;

	//テクスチャのピクセル色を取得
	outDiffuse = g_Texture.Sample(g_SamplerState, In.TexCoord);
	outDiffuse.rgb *= In.Diffuse.rgb*light;						//頂点色と明るさを乗算
	outDiffuse.a *= In.Diffuse.a;								//aに明るさは関係ないので別計算

	//カメラからピクセルへのベクトル
	float3 eyev = In.WorldPosition.xyz - CameraPosition.xyz;
	eyev = normalize(eyev);										//正規化する


	//スクリーン空間のx,y座標について、x.yの勾配を取得
	float2 dx, dy;
	dx = ddx(In.TexCoord);
	dy = ddy(In.TexCoord);
	//テクセルのサンプリング位置のオフセット値を調整
	float2  offset = eyev.xy * 0.003f;
	//テクセルのサンプリング位置
	float2 texel = In.TexCoord;

	float height = 0.0f;

	bool flg = false;
	while (!flg)
	{
		float4 NormalMap = tex2Dgrad(g_Texture1, texel, dx, dy);
		//
		////高さで比較する
		//if (NormalMap.a * 0.03f <= height)
		//{
		//	//法線ベクトルを取得
		//	float3 Normal = 2.0f * NormalMap.rgb - 1.0f;
		//
		//	//ハーフランバート拡散照明
		//	float color = dot(Normal, light);
		//	color = color * 0.5f + 0.5f;
		//	color = color * color;
		//
		//	outDiffuse = tex2Dgrad(g_SamplerState, texel, dx, dy) * color;
		//
		//	//ループ終了
		//	flg = true;
		//}
		//texel += offset;
		//height += eyev.z * 0.003f;
		flg = true;
	}



	//--------------------------------------------//
	//			  ブリンフォン鏡面反射			  //
	//--------------------------------------------//
	//ハーフベクトルの作成
	float3 halfv = eyev + Light.Direction.xyz;
	halfv = normalize(halfv);

	float specular = -dot(halfv, normal.xyz); //ハーフベクトルと法線の内積を計算
	specular = saturate(specular);
	specular = pow(specular, 30);

	outDiffuse.rgb += specular;	//スペキュラをディフューズとして足しこむ
}