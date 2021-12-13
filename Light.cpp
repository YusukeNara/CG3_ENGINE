#include "Light.h"

using namespace DirectX;

ID3D12Device *Light::dev = nullptr;

void Light::StaticInit(ID3D12Device *device)
{
	//最初期化チェック
	assert(!Light::dev);
	//nullチェック
	assert(device);
	//デバイスセット
	dev = device;
}

Light *Light::Create()
{
	//インスタンス生成
	Light *ins = new Light;
	//初期化
	ins->Init();
	//返却
	return ins;
}

void Light::Init()
{
	HRESULT result;
	result = dev->CreateCommittedResource(
		&CD3DX12_HEAP_PROPERTIES(D3D12_HEAP_TYPE_UPLOAD),
		D3D12_HEAP_FLAG_NONE,
		&CD3DX12_RESOURCE_DESC::Buffer((sizeof(ConstBufferData) + 0xff) & ~0xff),
		D3D12_RESOURCE_STATE_GENERIC_READ,
		nullptr,
		IID_PPV_ARGS(&constBuff)
	);

	TransferConstBufferData();

	if (FAILED(result)) { assert(0); }
}

void Light::TransferConstBufferData()
{
	HRESULT result;
	ConstBufferData *constMap = nullptr;
	result = constBuff->Map(0, nullptr, (void**)&constMap);
	if (SUCCEEDED(result)) {
		constMap->lightv = -lightDir;
		constMap->lightColor = lightColor;
		constBuff->Unmap(0, nullptr);
	}
}

void Light::SetLightDir(const XMVECTOR &lightDir)
{
	this->lightDir = XMVector3Normalize(lightDir);
	dirty = true;
}

void Light::SetLightColor(const XMFLOAT3 &lightColor)
{
	this->lightColor = lightColor;
	dirty = true;
}

void Light::Update()
{

	if (dirty) {
		TransferConstBufferData();
		dirty = false;
	}
}

void Light::Draw(ID3D12GraphicsCommandList *cmdlist, UINT rootparamIndex)
{
	//定数バッファセット
	cmdlist->SetGraphicsRootConstantBufferView(rootparamIndex, constBuff->GetGPUVirtualAddress());
}
