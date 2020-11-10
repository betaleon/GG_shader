
#include "main.h"
#include "renderer.h"
#include "field.h"



void CField::Init()
{
	VERTEX_3D vertex[4];

	vertex[0].Position = D3DXVECTOR3( -10.0f, 0.0f, 10.0f );
	vertex[0].Normal   = D3DXVECTOR3( 0.0f, 1.0f, 0.0f );
	vertex[0].Diffuse  = D3DXVECTOR4( 1.0f, 1.0f, 1.0f, 1.0f );
	vertex[0].TexCoord = D3DXVECTOR2( 0.0f, 0.0f );

	vertex[1].Position = D3DXVECTOR3( 10.0f, 0.0f, 10.0f );
	vertex[1].Normal   = D3DXVECTOR3( 0.0f, 1.0f, 0.0f );
	vertex[1].Diffuse  = D3DXVECTOR4( 1.0f, 1.0f, 1.0f, 1.0f );
	vertex[1].TexCoord = D3DXVECTOR2( 10.0f, 0.0f );

	vertex[2].Position = D3DXVECTOR3( -10.0f, 0.0f, -10.0f );
	vertex[2].Normal   = D3DXVECTOR3( 0.0f, 1.0f, 0.0f );
	vertex[2].Diffuse  = D3DXVECTOR4( 1.0f, 1.0f, 1.0f, 1.0f );
	vertex[2].TexCoord = D3DXVECTOR2( 0.0f, 10.0f );

	vertex[3].Position = D3DXVECTOR3( 10.0f, 0.0f, -10.0f );
	vertex[3].Normal   = D3DXVECTOR3( 0.0f, 1.0f, 0.0f );
	vertex[3].Diffuse  = D3DXVECTOR4( 1.0f, 1.0f, 1.0f, 1.0f );
	vertex[3].TexCoord = D3DXVECTOR2( 10.0f, 10.0f );


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
	D3DX11CreateShaderResourceViewFromFile(CRenderer::GetDevice(),
											"asset/texture/field004.jpg",
											NULL,
											NULL,
											&m_Texture,
											NULL);
	assert( m_Texture );



	m_Position = D3DXVECTOR3( 0.0f, 0.0f, 0.0f );
	m_Rotation = D3DXVECTOR3( 0.0f, 0.0f, 0.0f );
	m_Scale = D3DXVECTOR3( 1.0f, 1.0f, 1.0f );


	//ここにシェーダーファイルのロードを追加
//Load VertexShaderFile & Create Object
	CRenderer::CreateVertexShader(&m_VertexShader, &m_VertexLayout, "vertexLightingVS.cso");

	//Load PixelShaderFile & Create Object
	CRenderer::CreatePixelShader(&m_PixelShader, "vertexLightingPS.cso");


	//For Nvidia 
	//頂点シェーダーオブジェクトのセット
	CRenderer::GetDeviceContext()->VSSetShader(m_VertexShader, NULL, 0);
	//ピクセルシェーダーオブジェクトのセット
	CRenderer::GetDeviceContext()->PSSetShader(m_PixelShader, NULL, 0);


}


void CField::Uninit()
{

	m_VertexBuffer->Release();
	m_Texture->Release();


	//ここにシェーダーオブジェクトの解放を追加
	m_VertexLayout->Release();
	m_VertexShader->Release();
	m_PixelShader->Release();

}


void CField::Update()
{

}


void CField::Draw()
{


	//ここにシェーダー関連の描画準備を追加
	//インプットレイアウトのセット（DirectXへ頂点の構造を教える）
	CRenderer::GetDeviceContext()->IASetInputLayout(m_VertexLayout);
	//頂点シェーダーオブジェクトのセット
	CRenderer::GetDeviceContext()->VSSetShader(m_VertexShader, NULL, 0);
	//ピクセルシェーダーオブジェクトのセット
	CRenderer::GetDeviceContext()->PSSetShader(m_PixelShader, NULL, 0);

	// マトリクス設定
	D3DXMATRIX world, scale, rot, trans;
	D3DXMatrixScaling(&scale, m_Scale.x, m_Scale.y, m_Scale.z);
	D3DXMatrixRotationYawPitchRoll(&rot, m_Rotation.y, m_Rotation.x, m_Rotation.z);
	D3DXMatrixTranslation(&trans, m_Position.x, m_Position.y, m_Position.z);
	world = scale * rot * trans;
	CRenderer::SetWorldMatrix(&world);

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