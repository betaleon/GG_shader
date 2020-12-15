
#include "main.h"
#include "renderer.h"
#include "polygon.h"





void CPolygon::Init()
{
	VERTEX_3D vertex[4];

	vertex[0].Position = D3DXVECTOR3( 0.0f, 0.0f, 0.0f );
	vertex[0].Normal   = D3DXVECTOR3( 0.0f, 0.0f, 0.0f );
	vertex[0].Diffuse  = D3DXVECTOR4( 1.0f, 1.0f, 1.0f, 1.0f );
	vertex[0].TexCoord = D3DXVECTOR2( 0.0f, 0.0f );

	vertex[1].Position = D3DXVECTOR3( 300.0f, 0.0f, 0.0f );
	vertex[1].Normal   = D3DXVECTOR3( 0.0f, 0.0f, 0.0f );
	vertex[1].Diffuse  = D3DXVECTOR4( 1.0f, 1.0f, 1.0f, 1.0f );
	vertex[1].TexCoord = D3DXVECTOR2( 1.0f, 0.0f );

	vertex[2].Position = D3DXVECTOR3( 0.0f, 300.0f, 0.0f );
	vertex[2].Normal   = D3DXVECTOR3( 0.0f, 0.0f, 0.0f );
	vertex[2].Diffuse  = D3DXVECTOR4( 1.0f, 1.0f, 1.0f, 1.0f );
	vertex[2].TexCoord = D3DXVECTOR2( 0.0f, 1.0f );

	vertex[3].Position = D3DXVECTOR3( 300.0f, 300.0f, 0.0f );
	vertex[3].Normal   = D3DXVECTOR3( 0.0f, 0.0f, 0.0f );
	vertex[3].Diffuse  = D3DXVECTOR4( 1.0f, 1.0f, 1.0f, 1.0f );
	vertex[3].TexCoord = D3DXVECTOR2( 1.0f, 1.0f );


	// 頂点バッファ生成
	D3D11_BUFFER_DESC bd;
	ZeroMemory( &bd, sizeof(bd) );
	bd.Usage = D3D11_USAGE_DEFAULT;
	bd.ByteWidth = sizeof( VERTEX_3D ) * 4;
	bd.BindFlags = D3D11_BIND_VERTEX_BUFFER;
	bd.CPUAccessFlags = 0;

	D3D11_SUBRESOURCE_DATA sd;
	ZeroMemory( &sd, sizeof(sd) );
	sd.pSysMem = vertex;

	CRenderer::GetDevice()->CreateBuffer( &bd, &sd, &m_VertexBuffer );


	// テクスチャ読み込み
	D3DX11CreateShaderResourceViewFromFile( CRenderer::GetDevice(),
//											"asset/texture/field004.jpg",
											"asset/texture/kizuna.jpg",
											NULL,
											NULL,
											&m_Texture,
											NULL );
	assert(m_Texture);



	//ここにシェーダーファイルのロードを追加
	//Load VertexShaderFile & Create Object
	CRenderer::CreateVertexShader(&m_VertexShader, &m_VertexLayout, "unlitColorVS.cso");

	//Load PixelShaderFile & Create Object
	CRenderer::CreatePixelShader(&m_PixelShader, "unlitColorPS.cso");


	//For Nvidia 
	//頂点シェーダーオブジェクトのセット
	CRenderer::GetDeviceContext()->VSSetShader(m_VertexShader, NULL, 0);
	//ピクセルシェーダーオブジェクトのセット
	CRenderer::GetDeviceContext()->PSSetShader(m_PixelShader, NULL, 0);

}


void CPolygon::Uninit()
{

	m_VertexBuffer->Release();
	m_Texture->Release();


	//ここにシェーダーオブジェクトの解放を追加
	m_VertexLayout->Release();
	m_VertexShader->Release();
	m_PixelShader->Release();

}


void CPolygon::Update()
{


}


void CPolygon::Draw()
{


	//ここにシェーダー関連の描画準備を追加
	//インプットレイアウトのセット（DirectXへ頂点の構造を教える）
	CRenderer::GetDeviceContext()->IASetInputLayout(m_VertexLayout);
	//頂点シェーダーオブジェクトのセット
	CRenderer::GetDeviceContext()->VSSetShader(m_VertexShader,NULL,0);
	//ピクセルシェーダーオブジェクトのセット
	CRenderer::GetDeviceContext()->PSSetShader(m_PixelShader, NULL, 0);


	// マトリクス設定
	CRenderer::SetWorldViewProjection2D();


	// 頂点バッファ設定
	UINT stride = sizeof( VERTEX_3D );
	UINT offset = 0;
	CRenderer::GetDeviceContext()->IASetVertexBuffers( 0, 1, &m_VertexBuffer, &stride, &offset );

	// マテリアル設定
	MATERIAL material;
	ZeroMemory( &material, sizeof(material) );
	material.Diffuse = D3DXCOLOR( 1.0f, 1.0f, 1.0f, 1.0f );
	CRenderer::SetMaterial( material );

	// テクスチャ設定
	CRenderer::GetDeviceContext()->PSSetShaderResources(0, 1, &m_Texture);

	// プリミティブトポロジ設定
	CRenderer::GetDeviceContext()->IASetPrimitiveTopology( D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP );

	// ポリゴン描画
	CRenderer::GetDeviceContext()->Draw( 4, 0 );

}

//フォルダの中にテキストファイル作成
// UnlitColorVS.hlsl
// UnlitColorPS.hlsl
// common.hlsl