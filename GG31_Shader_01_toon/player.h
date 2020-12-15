#pragma once

#define SHADER_MAX 7

class CPlayer
{

private:
	D3DXVECTOR3	m_Position;
	D3DXVECTOR3	m_Rotation;
	D3DXVECTOR3	m_Scale;

	CModel* m_Model;

	ID3D11ShaderResourceView* m_TextureEnv = NULL;

	//������	�V�F�[�_�[�֘A�̕ϐ���ǉ�
	ID3D11VertexShader* m_VertexShader[SHADER_MAX];	//���_�V�F�[�_�[�I�u�W�F�N�g
	ID3D11PixelShader* m_PixelShader[SHADER_MAX];	//�s�N�Z���V�F�[�_�[�I�u�W�F�N�g

	ID3D11InputLayout* m_VertexLayout;	//���_�\���̂̍\����\���I�u�W�F�N�g

	BYTE m_ShaderNo;	//���s����V�F�[�_�[�̔ԍ�

public:
	void Init();
	void Uninit();
	void Update();
	void Draw();

};