using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class copy_mesh : MonoBehaviour
{

    public MeshFilter obj;
    public BoxCollider m_Collider;
    void Update()
    {
        Mesh mesh = obj.mesh;
        Vector3[] vertices = mesh.vertices;

        for (var i = 0; i < vertices.Length; i++)
        {

            if (m_Collider.bounds.Contains( GetVertexWorldPosition(vertices[i], obj.gameObject.transform)))
            {
                print("inside...");
                
                vertices[i] = new Vector3(vertices[i].x, vertices[i].y - 0.01f, vertices[i].z);
            }
        }
        mesh.vertices = vertices;

    }
    public Vector3 GetVertexWorldPosition(Vector3 vertex, Transform owner)
    {
        return owner.localToWorldMatrix.MultiplyPoint3x4(vertex);
    }
}
