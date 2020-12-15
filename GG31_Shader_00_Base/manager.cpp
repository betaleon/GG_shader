#include "main.h"
#include "manager.h"
#include "renderer.h"
#include "input.h"
#include "debugimgui.h"
#include "imgui.h"
#include "polygon.h"
#include "field.h"
#include "camera.h"
#include "model.h"
#include "player.h"

CPolygon*		g_Polygon;
CField*			g_Field;
CCamera*		g_Camera;
CPlayer*		g_Player;

void CManager::Init()
{
	CRenderer::Init();
	CDebugGui::Init();
	CInput::Init();

	g_Polygon = new CPolygon();
	g_Polygon->Init();

	g_Field = new CField();
	g_Field->Init();

	g_Camera = new CCamera();
	g_Camera->Init();

	g_Player = new CPlayer();
	g_Player->Init();
}

void CManager::Uninit()
{

	g_Polygon->Uninit();
	delete g_Polygon;

	g_Field->Uninit();
	delete g_Field;

	g_Camera->Uninit();
	delete g_Camera;

	g_Player->Uninit();
	delete g_Player;


	CInput::Uninit();
	CDebugGui::Finalize();
	CRenderer::Uninit();

}

void CManager::Update()
{
	CInput::Update();
	CDebugGui::Update();


	g_Camera->Update();

	g_Field->Update();

	g_Polygon->Update();

	g_Player->Update();

}

void CManager::Draw()
{
	CRenderer::Begin();
	CDebugGui::Begin();

	g_Camera->Draw();

	LIGHT light;
	light.Enable = true;
	light.Direction = D3DXVECTOR4( 1.0f, -0.5f, 0.0f, 0.0f );
	D3DXVec4Normalize( &light.Direction, &light.Direction );
	light.Ambient = D3DXCOLOR( 0.1f, 0.1f, 0.1f, 1.0f );
	light.Diffuse = D3DXCOLOR( 1.0f, 1.0f, 1.0f, 1.0f );
	CRenderer::SetLight(light);

	g_Field->Draw();

	g_Player->Draw();

	light.Enable = false;
	CRenderer::SetLight(light);

	g_Polygon->Draw();

	ImGui::SetNextWindowPos(ImVec2(20, 20));
	ImGui::Begin("Debug");

	ImGui::End();

	CDebugGui::End();
	CRenderer::End();
}
