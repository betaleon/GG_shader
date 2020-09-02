//頂点シェーダー

#include "common.hlsl"

//inは入力されてくるデータ
//outは出力するデータ

void main(in VS_IN In, out PS_IN Out)
{

	matrix wvp;		//計算用行列

	//wvp = ワールド行列*ビュー行列
	wvp = mul(World, View);

	//wvp = wvp * プロジェクション行列
	wvp = mul(wvp, Projection);

	//頂点座標 * 変換行列を出力
	Out.Position = mul(In.Position,wvp);

	//頂点カラー
	Out.Diffuse = In.Diffuse;

	//テクスチャ座標
	Out.TexCoord = In.TexCoord;


}