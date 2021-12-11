Shader "Unitycoder/gradientBarSurfaceShader" {
	Properties {
		_TopLine ("Top Line Y", Float) = 0
		_BottomLine ("Bottom Line Y", Float) = 0
		_OverTopColor ("OverTheTopColor", Vector) = (1,1,1,1)
		_GradientTopColor ("GradientTopColor", Vector) = (1,0,0,1)
		_GradientBottomColor ("GradientBottomColor", Vector) = (0,1,0,0)
		_BelowBottomColor ("BelowTheBottomColor", Vector) = (0,0,0,0)
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Cull Off
			GpuProgramID 25178
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					bool u_xlatb4;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb4 = vs_TEXCOORD4.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					bool u_xlatb4;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb4 = vs_TEXCOORD4.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					bool u_xlatb4;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb4 = vs_TEXCOORD4.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_6;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_6;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_6;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					bool u_xlatb5;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb5 = vs_TEXCOORD4.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					bool u_xlatb5;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb5 = vs_TEXCOORD4.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					bool u_xlatb5;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb5 = vs_TEXCOORD4.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
					    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					mediump float u_xlat16_7;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat16_5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
					    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					mediump float u_xlat16_7;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat16_5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
					    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					mediump float u_xlat16_7;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat16_5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					bool u_xlatb4;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb4 = vs_TEXCOORD4.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					bool u_xlatb4;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb4 = vs_TEXCOORD4.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					bool u_xlatb4;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb4 = vs_TEXCOORD4.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_6;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_6;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_6;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat25;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    u_xlat3 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat1.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat1.xxxx + u_xlat5;
					    u_xlat3 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat2 + u_xlat4;
					    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat3.xyz = u_xlat2.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = unity_LightColor[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat2.xyz = unity_LightColor[3].xyz * u_xlat2.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat2.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_6.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_6.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_6.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * u_xlat3.xyz + u_xlat16_6.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					bool u_xlatb5;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb5 = vs_TEXCOORD4.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat25;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    u_xlat3 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat1.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat1.xxxx + u_xlat5;
					    u_xlat3 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat2 + u_xlat4;
					    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat3.xyz = u_xlat2.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = unity_LightColor[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat2.xyz = unity_LightColor[3].xyz * u_xlat2.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat2.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_6.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_6.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_6.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * u_xlat3.xyz + u_xlat16_6.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					bool u_xlatb5;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb5 = vs_TEXCOORD4.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat25;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    u_xlat3 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat1.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat1.xxxx + u_xlat5;
					    u_xlat3 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat2 + u_xlat4;
					    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat3.xyz = u_xlat2.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = unity_LightColor[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat2.xyz = unity_LightColor[3].xyz * u_xlat2.www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat2.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_6.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_6.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_6.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * u_xlat3.xyz + u_xlat16_6.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					bool u_xlatb5;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
					    u_xlatb5 = vs_TEXCOORD4.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					mediump float u_xlat16_7;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat16_5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					mediump float u_xlat16_7;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat16_5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_5;
					mediump float u_xlat16_7;
					bool u_xlatb15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat16_5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_5.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_5.x;
					    u_xlat16_5.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb15 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb15)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = vs_TEXCOORD0.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + vs_TEXCOORD2.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_4.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat16_17 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_17 = max(u_xlat16_17, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_17) + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 120854
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTexture0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xx).x;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTexture0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xx).x;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTexture0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xx).x;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "POINT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTexture0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).x;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "POINT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTexture0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).x;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "POINT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTexture0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).x;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTexture0;
					uniform highp sampler2D _LightTextureB0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
					    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xy).w;
					    u_xlatb3 = 0.0<vs_TEXCOORD2.z;
					    u_xlat16_10 = (u_xlatb3) ? 1.0 : 0.0;
					    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
					    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
					    u_xlat16_2.xyz = vec3(u_xlat16_10) * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTexture0;
					uniform highp sampler2D _LightTextureB0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
					    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xy).w;
					    u_xlatb3 = 0.0<vs_TEXCOORD2.z;
					    u_xlat16_10 = (u_xlatb3) ? 1.0 : 0.0;
					    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
					    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
					    u_xlat16_2.xyz = vec3(u_xlat16_10) * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTexture0;
					uniform highp sampler2D _LightTextureB0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
					    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xy).w;
					    u_xlatb3 = 0.0<vs_TEXCOORD2.z;
					    u_xlat16_10 = (u_xlatb3) ? 1.0 : 0.0;
					    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
					    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
					    u_xlat16_2.xyz = vec3(u_xlat16_10) * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "SPOT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTexture0;
					UNITY_LOCATION(1) uniform highp sampler2D _LightTextureB0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec2 u_xlat1;
					bool u_xlatb1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat12;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
					    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat12 = texture(_LightTexture0, u_xlat1.xy).w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(0.0<u_xlat0.z);
					#else
					    u_xlatb1 = 0.0<u_xlat0.z;
					#endif
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
					    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
					    u_xlat16_2.x = u_xlat12 * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "SPOT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTexture0;
					UNITY_LOCATION(1) uniform highp sampler2D _LightTextureB0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec2 u_xlat1;
					bool u_xlatb1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat12;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
					    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat12 = texture(_LightTexture0, u_xlat1.xy).w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(0.0<u_xlat0.z);
					#else
					    u_xlatb1 = 0.0<u_xlat0.z;
					#endif
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
					    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
					    u_xlat16_2.x = u_xlat12 * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "SPOT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTexture0;
					UNITY_LOCATION(1) uniform highp sampler2D _LightTextureB0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec2 u_xlat1;
					bool u_xlatb1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat12;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
					    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat12 = texture(_LightTexture0, u_xlat1.xy).w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(0.0<u_xlat0.z);
					#else
					    u_xlatb1 = 0.0<u_xlat0.z;
					#endif
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
					    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
					    u_xlat16_2.x = u_xlat12 * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_4.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_4.x;
					    u_xlat16_4.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb12 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb12)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTextureB0;
					uniform highp samplerCube _LightTexture0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					float u_xlat3;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
					    u_xlat3 = textureCube(_LightTexture0, vs_TEXCOORD2.xyz).w;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTextureB0;
					uniform highp samplerCube _LightTexture0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					float u_xlat3;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
					    u_xlat3 = textureCube(_LightTexture0, vs_TEXCOORD2.xyz).w;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTextureB0;
					uniform highp samplerCube _LightTexture0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					float u_xlat3;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
					    u_xlat3 = textureCube(_LightTexture0, vs_TEXCOORD2.xyz).w;
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTextureB0;
					UNITY_LOCATION(1) uniform highp samplerCube _LightTexture0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					float u_xlat3;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat9)).x;
					    u_xlat0.x = u_xlat0.x * u_xlat3;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTextureB0;
					UNITY_LOCATION(1) uniform highp samplerCube _LightTexture0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					float u_xlat3;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat9)).x;
					    u_xlat0.x = u_xlat0.x * u_xlat3;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTextureB0;
					UNITY_LOCATION(1) uniform highp samplerCube _LightTexture0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					float u_xlat3;
					mediump vec3 u_xlat16_3;
					float u_xlat9;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat9)).x;
					    u_xlat0.x = u_xlat0.x * u_xlat3;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec2 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTexture0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec2 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.x = texture2D(_LightTexture0, vs_TEXCOORD2.xy).w;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec2 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTexture0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec2 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.x = texture2D(_LightTexture0, vs_TEXCOORD2.xy).w;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec2 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform highp sampler2D _LightTexture0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec2 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.x = texture2D(_LightTexture0, vs_TEXCOORD2.xy).w;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTexture0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
					    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTexture0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
					    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform highp sampler2D _LightTexture0;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
					    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
					    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "POINT" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "POINT" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "POINT" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "SPOT" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "SPOT" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "SPOT" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3"
				}
			}
		}
		Pass {
			Name "PREPASS"
			Tags { "LIGHTMODE" = "PREPASSBASE" "RenderType" = "Opaque" }
			Cull Off
			GpuProgramID 158486
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					varying highp vec3 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					varying highp vec3 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					varying highp vec3 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
			}
		}
		Pass {
			Name "PREPASS"
			Tags { "LIGHTMODE" = "PREPASSFINAL" "RenderType" = "Opaque" }
			ZWrite Off
			Cull Off
			GpuProgramID 221572
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = (-u_xlat16_2.xyz) + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _LightBuffer;
					in highp vec3 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD0.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_3.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
					    u_xlat16_3.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(vs_TEXCOORD0.y<_BottomLine);
					#else
					    u_xlatb9 = vs_TEXCOORD0.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb9)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD0.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD0.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat0.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
			Cull Off
			GpuProgramID 287437
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    SV_Target0.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    SV_Target3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    SV_Target3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					varying highp vec3 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    SV_Target3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    SV_Target3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    SV_Target3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump float _TopLine;
					uniform 	mediump float _BottomLine;
					uniform 	mediump vec4 _OverTopColor;
					uniform 	mediump vec4 _BelowBottomColor;
					uniform 	mediump vec4 _GradientTopColor;
					uniform 	mediump vec4 _GradientBottomColor;
					in highp vec3 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = max(vs_TEXCOORD1.y, _BottomLine);
					    u_xlat0.x = min(u_xlat0.x, _TopLine);
					    u_xlat0.x = u_xlat0.x + (-_BottomLine);
					    u_xlat16_2.x = (-_BottomLine) + _TopLine;
					    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
					    u_xlat16_2.xyz = _GradientTopColor.xyz + (-_GradientBottomColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + _GradientBottomColor.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(vs_TEXCOORD1.y<_BottomLine);
					#else
					    u_xlatb6 = vs_TEXCOORD1.y<_BottomLine;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _BelowBottomColor.xyz : u_xlat0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_TopLine<vs_TEXCOORD1.y);
					#else
					    u_xlatb0 = _TopLine<vs_TEXCOORD1.y;
					#endif
					    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _OverTopColor.xyz : u_xlat16_1.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz;
					    SV_Target3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.w = 1.0;
					    SV_Target2 = u_xlat0;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
			}
		}
	}
	Fallback "Diffuse"
}