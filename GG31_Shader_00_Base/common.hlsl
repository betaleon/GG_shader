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

//ライトオブジェクト構造体とコンスタントバッファ
struct LIGHT
{
	bool Enable;
	bool3 Dummy;		//4の倍数にすると効率がいいので調整用、実はC言語でも同じだがVS2017がやってくれている
	float4 Direction;
	float4 Diffuse;
	float4 Ambient;

};

cbuffer LightBuffer : register(b4)	//コンスタントバッファ4番とする
{
	LIGHT Light;			//ライト構造体
}

cbuffer CameraBuffer : register(b5)	//バッファの5番とする
{
	float4	CameraPosition;	//カメラ座標を受け取る変数
}