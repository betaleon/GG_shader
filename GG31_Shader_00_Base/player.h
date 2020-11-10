#pragma once

class CPlayer
{

private:
	D3DXVECTOR3	m_Position;
	D3DXVECTOR3	m_Rotation;
	D3DXVECTOR3	m_Scale;

	CModel* m_Model;

	//ここに	シェーダー関連の変数を追加
	ID3D11VertexShader* m_VertexShader;	//頂点シェーダーオブジェクト
	ID3D11PixelShader* m_PixelShader;	//ピクセルシェーダーオブジェクト

	ID3D11InputLayout* m_VertexLayout;	//頂点構造体の構成を表すオブジェクト

public:
	void Init();
	void Uninit();
	void Update();
	void Draw();

};