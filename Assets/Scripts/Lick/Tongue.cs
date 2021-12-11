using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Lick 
{
    public class Tongue : MonoBehaviour
    {
        [HideInInspector]public PlayerMove player;
        [HideInInspector]public MeshFilter obj;
        Collider m_collider;
        public EatEffect ef;
        public bool is_active_eat_effect;
        private void Start()
        {
            player = GetComponentInParent<PlayerMove>();
            m_collider = GetComponent<Collider>();
        }
        public float y_limit;
        private void Update()
        {
            if (obj == null || player.pressed_value > 5 || !player.IsCanLick)
            {
                is_active_eat_effect = false;
            }
            else
            {
                is_active_eat_effect = true;
                Mesh mesh = obj.mesh;
                Vector3[] vertices = mesh.vertices;
                for (var i = 0; i < vertices.Length; i++)
                {
                    Vector3 current_point = GetVertexWorldPosition(vertices[i], obj.transform);
                    if (m_collider.bounds.Contains(current_point))
                    {
                        vertices[i] = GetLocalPosition(m_collider.ClosestPointOnBounds(new Vector3(current_point.x, current_point.y - 1f, current_point.z)), obj.transform);
                    }

                }
                mesh.vertices = vertices;
            }

        }
        public Vector3 GetLocalPosition(Vector3 vertex, Transform owner)
        {
            return owner.worldToLocalMatrix.MultiplyPoint3x4(vertex);
        }
        public Vector3 GetVertexWorldPosition(Vector3 vertex, Transform owner)
        {
            return owner.localToWorldMatrix.MultiplyPoint3x4(vertex);
        }
        private void OnTriggerEnter(Collider other)
        {

            if (other.GetComponent<Cake>() != null)
            {
                player.is_on_cake = true;
                player.SetEmoji(other.GetComponent<Cake>().this_emoji);
                ef.Set(other.GetComponent<Cake>().this_effect);
            }
            if (other.gameObject.GetComponent<Fracture>() != null && player.pressed_value < 5 && player.IsCanLick)
            {
                other.GetComponent<Fracture>().ActiveFraction();
            }
            if (other.gameObject.GetComponent<SingleCake>() != null)
            {
                other.GetComponent<SingleCake>().Active();
            }
        }
        private void OnTriggerExit(Collider other)
        {
            if (other.GetComponent<Cake>() != null)
            {
                player.is_on_cake = false;
            }
        }
    }
}


