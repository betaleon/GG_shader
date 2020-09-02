//このファイルは他のシェーダーファイルへインクルードします

//各種マトリックスバッファ　コンスタントバッファ定義

cbuffer WorldBuffer : register(b0)
{
	matrix World;		//ワールド行列変数
}

cbuffer ViewBuffer : register (b1)
{
	matrix View;		//ビュー行列変数
}

cbuffer ProjectionBuffer : register (b2)
{
	matrix Projection;	//プロジェクション行列変数
}

//頂点シェーダーへ入力されるデータを構造体の形で表現
//これは頂点バッファの内容そのもの
struct VS_IN
{
	float4 Position	:	POSITION0;	//頂点座標
	float4 Normal	:	NORMAL0;	//法線
	float4 Diffuse	:	COLOR0;		//カラー
	float2 TexCoord :	TEXCOORD0;	//テクスチャ座標
};
//ピクセルシェーダーへ入力されるデータを構造体の形で表現
struct PS_IN
{
	float4 Position			:	SV_POSITION;	//頂点座標
	float4 WorldPosition	: POSITION0;
	float4 Normal			:	NORMAL0;		//法線
	float4 Diffuse			:	COLOR0;			//カラー
	float2 TexCoord			:	TEXCOORD0;		//テクスチャ座標
};