#pragma once

#define SHADER_MAX 4

class CPlayer
{

private:
	D3DXVECTOR3	m_Position;
	D3DXVECTOR3	m_Rotation;
	D3DXVECTOR3	m_Scale;

	CModel* m_Model;

	//ここに	シェーダー関連の変数を追加
	ID3D11VertexShader* m_VertexShader[SHADER_MAX];	//頂点シェーダーオブジェクト
	ID3D11PixelShader* m_PixelShader[SHADER_MAX];	//ピクセルシェーダーオブジェクト

	ID3D11InputLayout* m_VertexLayout;	//頂点構造体の構成を表すオブジェクト

	BYTE m_ShaderNo;	//実行するシェーダーの番号

public:
	void Init();
	void Uninit();
	void Update();
	void Draw();

};