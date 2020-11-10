#pragma once


class CField
{

private:
	D3DXVECTOR3	m_Position;
	D3DXVECTOR3	m_Rotation;
	D3DXVECTOR3	m_Scale;

	ID3D11Buffer*				m_VertexBuffer = NULL;
	ID3D11ShaderResourceView*	m_Texture = NULL;


	//������	�V�F�[�_�[�֘A�̕ϐ���ǉ�
	ID3D11VertexShader* m_VertexShader;	//���_�V�F�[�_�[�I�u�W�F�N�g
	ID3D11PixelShader* m_PixelShader;	//�s�N�Z���V�F�[�_�[�I�u�W�F�N�g

	ID3D11InputLayout* m_VertexLayout;	//���_�\���̂̍\����\���I�u�W�F�N�g


public:
	void Init();
	void Uninit();
	void Update();
	void Draw();

};