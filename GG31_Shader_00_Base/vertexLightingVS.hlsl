#include "common.hlsl"

void main(in VS_IN In, out PS_IN Out)
{
	//頂点法線をワールド行列で回転させる(頂点と同じ回転をさせる)
	float4 worldNormal, normal;	//ローカル変数を作成

	normal = float4(In.Normal.xyz,0.0);			//法線ベクトルのwを0とする(行列を乗算しても平行移動しない)
	worldNormal = mul(normal,World);				//法線をワールド行列で回転
	worldNormal = normalize(worldNormal);			//回転後の法線を正規化する

	//光源計算の処理を合成する 明るさの計算
	float light = -dot(Light.Direction.xyz, worldNormal.xyz);	//光ベクトルと法線の内積 XYZ要素のみで計算
	light = saturate(light);									//明るさを0~1の間で飽和化する

	Out.Diffuse = light;		//明るさを頂点色として出力
	Out.Diffuse = In.Diffuse.a;	//念のため

	matrix wvp;
	wvp = mul(World, View);
	wvp = mul(wvp, Projection);	//変換行列作成
	
	Out.Position = mul(In.Position, wvp);	//頂点出力
	Out.Normal = worldNormal;				//回転後の法線出力 In.Normalではなく回転後のものを出力
	Out.TexCoord = In.TexCoord;				//テクスチャ座標出力


}