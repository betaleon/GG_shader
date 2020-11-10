#include "main.h"
#include "manager.h"
#include "renderer.h"
#include "model.h"
#include "player.h"
#include "input.h"

void CPlayer::Init()
{
	m_Model = new CModel();
	m_Model->Load( "asset\\model\\horse_v5.obj" );

	m_Position = D3DXVECTOR3( 1.0f, 1.0f, -3.0f );
	m_Rotation = D3DXVECTOR3( 0.0f, -2.0f, 0.0f );
	m_Scale = D3DXVECTOR3( 0.5f, 0.5f, 0.5f );

	//�o�[�e�b�N�X�V�F�[�_�̃t�@�C����(VS��PS�͑΂ɂȂ�悤�ɂ���B���������ē����t�@�C�������Ԃ��Ƃ�����B)
	const char* VS_FileName[] = {
		"unlitColorVS.cso",
		"vertexLightingVS.cso",	
		"pixelLightingVS.cso",
		"pixelLightingVS.cso",
		"pixelLightingVS.cso",
	};

	//�s�N�Z���V�F�[�_�̃t�@�C����
	const char* PS_FileName[] = {
		"unlitColorPS.cso",
		"vertexLightingPS.cso",
		"pixelLightingPS.cso",
		"pixelLightingBlinnPS.cso",
		"pixelLightingRimPS.cso"
	};

	for (int i = 0; i < SHADER_MAX; i++)
	{
		//�����ɃV�F�[�_�[�t�@�C���̃��[�h��ǉ�
		CRenderer::CreateVertexShader(&m_VertexShader[i], &m_VertexLayout, VS_FileName[i]);
		CRenderer::CreatePixelShader(&m_PixelShader[i], PS_FileName[i]);
	}

	m_ShaderNo = 0;

	//For Nvidia 
	//���_�V�F�[�_�[�I�u�W�F�N�g�̃Z�b�g
	CRenderer::GetDeviceContext()->VSSetShader(m_VertexShader[m_ShaderNo], NULL, 0);
	//�s�N�Z���V�F�[�_�[�I�u�W�F�N�g�̃Z�b�g
	CRenderer::GetDeviceContext()->PSSetShader(m_PixelShader[m_ShaderNo], NULL, 0);

}

void CPlayer::Uninit()
{
	m_Model->Unload();
	delete m_Model;

	//�����ɃV�F�[�_�[�I�u�W�F�N�g�̉����ǉ�
	m_VertexLayout->Release();
	for (int i = 0; i < SHADER_MAX; i++)
	{
		m_VertexShader[i]->Release();
		m_PixelShader[i]->Release();
	}
}


void CPlayer::Update()
{
	//���E�㉺�ړ�
	if (CInput::GetKeyPress('A'))
		m_Position.x -= 0.1f;

	if (CInput::GetKeyPress('D'))
		m_Position.x += 0.1f;

	if (CInput::GetKeyPress('W'))
		m_Position.z += 0.1f;

	if (CInput::GetKeyPress('S'))
		m_Position.z -= 0.1f;

	//��]
	if (CInput::GetKeyPress('R'))
		m_Rotation.x -= 0.1f;
	if (CInput::GetKeyPress('F'))
		m_Rotation.x += 0.1f;

	if (CInput::GetKeyPress('Q'))
		m_Rotation.y -= 0.1f;
	if (CInput::GetKeyPress('E'))
		m_Rotation.y += 0.1f;

	if (CInput::GetKeyTrigger('Z'))
	{
		if (m_ShaderNo >= SHADER_MAX - 1)	
			m_ShaderNo = 0;
		else 		
			m_ShaderNo++;
	}
}

void CPlayer::Draw()
{

	//�����ɃV�F�[�_�[�֘A�̕`�揀����ǉ�
	//�C���v�b�g���C�A�E�g�̃Z�b�g�iDirectX�֒��_�̍\����������j
	CRenderer::GetDeviceContext()->IASetInputLayout(m_VertexLayout);
	//���_�V�F�[�_�[�I�u�W�F�N�g�̃Z�b�g
	CRenderer::GetDeviceContext()->VSSetShader(m_VertexShader[m_ShaderNo], NULL, 0);
	//�s�N�Z���V�F�[�_�[�I�u�W�F�N�g�̃Z�b�g
	CRenderer::GetDeviceContext()->PSSetShader(m_PixelShader[m_ShaderNo], NULL, 0);

	// �}�g���N�X�ݒ�
	D3DXMATRIX world, scale, rot, trans;
	D3DXMatrixScaling(&scale, m_Scale.x, m_Scale.y, m_Scale.z);
	D3DXMatrixRotationYawPitchRoll(&rot, m_Rotation.y, m_Rotation.x, m_Rotation.z);
	D3DXMatrixTranslation(&trans, m_Position.x, m_Position.y, m_Position.z);
	world = scale * rot * trans;

	CRenderer::SetWorldMatrix(&world);

	m_Model->Draw();
}


