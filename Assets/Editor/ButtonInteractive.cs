using UnityEngine;
using System.Collections;
using UnityEditor;

[CustomEditor(typeof(CreatLevelInspector))]
public class customButton : Editor
{
    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();

        CreatLevelInspector myScript = (CreatLevelInspector)target;
        if (GUILayout.Button("Creat Object"))
        {
            myScript.CreatNewLevel();
        }
    }

}